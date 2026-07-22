#!/usr/bin/env bash
# Link (or copy) every entry in link.tsv into place.
#
# Idempotent: an entry that is already linked correctly is left alone. A
# broken symlink is repaired. A real file sitting at a target is backed up
# to <target>.bak before being replaced. A missing source is reported and
# skipped rather than being turned into a dangling link.
#
# Exits nonzero if any entry was skipped or failed, so a partial run is
# never mistaken for a clean one.
#
# Usage: link.sh [-n|--dry-run] [-v|--verbose]

set -u

DOTFILES_HOME=$(dirname -- "$(readlink -f -- "$0")")
# Not named *.manifest: the global gitignore carries `*.manifest` from a
# Python template, which would silently keep this file out of the repository.
MANIFEST=$DOTFILES_HOME/link.tsv

dry_run=0
verbose=0

usage() {
    sed -n '2,12p' "$0" | sed 's/^# \{0,1\}//'
}

while [ $# -gt 0 ]; do
    case "$1" in
        -n | --dry-run) dry_run=1 ;;
        -v | --verbose) verbose=1 ;;
        -h | --help)
            usage
            exit 0
            ;;
        *)
            printf '%s\n' "unknown option: $1" >&2
            usage >&2
            exit 2
            ;;
    esac
    shift
done

# Color is an enhancement only; the icon and label always survive without it.
if [ -t 2 ] && [ -z "${NO_COLOR:-}" ]; then
    c_warn=$'\033[33m'
    c_err=$'\033[31m'
    c_off=$'\033[0m'
else
    c_warn=''
    c_err=''
    c_off=''
fi

n_ok=0
n_linked=0
n_fixed=0
n_backed_up=0
n_copied=0
n_dir=0
n_skipped=0
n_failed=0

warn() { printf '%s🟠 WARNING%s %s\n' "$c_warn" "$c_off" "$1" >&2; }
err() { printf '%s❌ ERROR%s %s\n' "$c_err" "$c_off" "$1" >&2; }
say() { printf '%s\n' "$1"; }
detail() { [ "$verbose" -eq 1 ] && printf '         %s\n' "$1"; return 0; }

# A leading `~` in a manifest target is literal data, not shell syntax, so
# it has to be expanded here rather than by the parser.
expand_tilde() {
    case "$1" in
        '~') printf '%s' "$HOME" ;;
        '~/'*) printf '%s' "$HOME/${1#'~/'}" ;;
        *) printf '%s' "$1" ;;
    esac
}

ensure_parent() {
    parent=$(dirname -- "$1")
    [ -d "$parent" ] && return 0
    if [ "$dry_run" -eq 1 ]; then
        detail "would mkdir -p $parent"
        return 0
    fi
    mkdir -p -- "$parent"
}

# Move a real (non-symlink) file or directory aside before replacing it.
back_up() {
    if [ "$dry_run" -eq 1 ]; then
        say "would back up  $1 -> $1.bak"
        return 0
    fi
    rm -rf -- "$1.bak" && mv -- "$1" "$1.bak"
}

link_entry() {
    src=$1
    dst=$2

    if [ -L "$dst" ] && [ -e "$dst" ]; then
        # Already a working symlink, but not necessarily to our source.
        current=$(readlink -f -- "$dst")
        if [ "$current" = "$(readlink -f -- "$src")" ]; then
            detail "already ok    $dst"
            n_ok=$((n_ok + 1))
            return 0
        fi
        warn "$dst points at $current, relinking to $src"
        if [ "$dry_run" -eq 1 ]; then
            n_fixed=$((n_fixed + 1))
            return 0
        fi
        ln -sfn -- "$src" "$dst" || return 1
        n_fixed=$((n_fixed + 1))
        return 0
    fi

    if [ -L "$dst" ]; then
        # Symlink that resolves to nothing.
        say "fixed broken  $dst"
        [ "$dry_run" -eq 1 ] && {
            n_fixed=$((n_fixed + 1))
            return 0
        }
        ln -sfn -- "$src" "$dst" || return 1
        n_fixed=$((n_fixed + 1))
        return 0
    fi

    if [ -e "$dst" ]; then
        # A real file or directory is in the way.
        warn "$dst exists and is not a symlink; backing it up to $dst.bak"
        back_up "$dst" || return 1
        [ "$dry_run" -eq 1 ] && {
            n_backed_up=$((n_backed_up + 1))
            return 0
        }
        ln -sfn -- "$src" "$dst" || return 1
        n_backed_up=$((n_backed_up + 1))
        return 0
    fi

    say "linked        $dst"
    [ "$dry_run" -eq 1 ] && {
        n_linked=$((n_linked + 1))
        return 0
    }
    ln -s -- "$src" "$dst" || return 1
    n_linked=$((n_linked + 1))
}

# Copied rather than linked because the destination is meant to be edited
# locally. That makes an unconditional copy destructive, so an existing file
# whose contents differ is backed up before being overwritten.
copy_entry() {
    src=$1
    dst=$2

    if [ -e "$dst" ] && cmp -s -- "$src" "$dst"; then
        detail "already ok    $dst"
        n_ok=$((n_ok + 1))
        return 0
    fi

    if [ -e "$dst" ]; then
        warn "$dst differs from the repository copy; backing it up to $dst.bak"
        back_up "$dst" || return 1
        [ "$dry_run" -eq 1 ] && {
            n_backed_up=$((n_backed_up + 1))
            return 0
        }
        cp -- "$src" "$dst" || return 1
        n_backed_up=$((n_backed_up + 1))
        return 0
    fi

    say "copied        $dst"
    [ "$dry_run" -eq 1 ] && {
        n_copied=$((n_copied + 1))
        return 0
    }
    cp -- "$src" "$dst" || return 1
    n_copied=$((n_copied + 1))
}

if [ ! -f "$MANIFEST" ]; then
    err "manifest not found: $MANIFEST"
    exit 1
fi

[ "$dry_run" -eq 1 ] && say "(dry run — no changes will be made)"

while IFS=$'\t' read -r type source target || [ -n "${type:-}" ]; do
    case "${type:-}" in
        '' | '#'*) continue ;;
    esac

    # Guards against a malformed row silently doing the wrong thing: tab is
    # an IFS whitespace character, so an empty column collapses and shifts
    # every field after it left.
    if [ -z "${target:-}" ] || [ -z "${source:-}" ]; then
        err "malformed manifest row (needs 3 tab-separated fields): $type ${source:-} ${target:-}"
        n_failed=$((n_failed + 1))
        continue
    fi

    target=$(expand_tilde "$target")

    if [ "$type" = dir ]; then
        detail "dir           $target"
        if [ ! -d "$target" ]; then
            say "created dir   $target"
            if [ "$dry_run" -eq 0 ] && ! mkdir -p -- "$target"; then
                err "could not create directory: $target"
                n_failed=$((n_failed + 1))
                continue
            fi
        fi
        n_dir=$((n_dir + 1))
        continue
    fi

    source=$DOTFILES_HOME/$source
    detail "$source -> $target"

    if [ ! -e "$source" ]; then
        warn "missing source, skipping: $source"
        n_skipped=$((n_skipped + 1))
        continue
    fi

    if ! ensure_parent "$target"; then
        err "could not create parent directory for: $target"
        n_failed=$((n_failed + 1))
        continue
    fi

    case "$type" in
        link)
            link_entry "$source" "$target" || {
                err "failed to link: $target"
                n_failed=$((n_failed + 1))
            }
            ;;
        copy)
            copy_entry "$source" "$target" || {
                err "failed to copy: $target"
                n_failed=$((n_failed + 1))
            }
            ;;
        *)
            warn "unknown entry type '$type' for $target, skipping"
            n_skipped=$((n_skipped + 1))
            ;;
    esac
done < "$MANIFEST"

printf '\n%s\n' "unchanged $n_ok  linked $n_linked  relinked $n_fixed  backed up $n_backed_up  copied $n_copied  dirs $n_dir  skipped $n_skipped  failed $n_failed"

if [ "$n_failed" -gt 0 ] || [ "$n_skipped" -gt 0 ]; then
    err "$((n_failed + n_skipped)) entr$([ $((n_failed + n_skipped)) -eq 1 ] && printf y || printf ies) did not complete; see messages above"
    exit 1
fi
