Status: Implemented

# Declarative link-manifest for link.sh

## Task

Harden `link.sh` (the darwin branch's dotfiles linker) so a run can never
leave the environment in a silently-broken or silently-incomplete state, and
replace its hand-paired `mkdir -p` / `link_file` call list with a single
declarative manifest. This is Phase 1 of a two-phase plan; Phase 2 (merging
the darwin/linux/etc. branches around a shared manifest+engine) is recorded
here as future work only — not implemented now.

### Why now

Four gaps remain in the current script:

1. Every dotfile needs a hand-paired entry in a `mkdir -p {a,b,c}` brace list
   kept in sync by hand. This is the main source of drift — adding a file and
   forgetting its directory (or vice versa) is silent until the link fails.
2. No handling for a destination that is a **real file or directory** rather
   than a symlink. When an app writes its own default config before `link.sh`
   runs, `ln -s` fails against it; the run continues and reports nothing.
3. No handling for a **missing source** — the script will happily create a
   dangling symlink pointing at a file the repo doesn't have.
4. A partial run prints nothing per entry and **always exits 0**, so a failed
   or skipped entry is indistinguishable from a clean run.

Note: the broken-symlink bug that originally motivated this work (`[ -f "$2" ]
&& [ ! -e "$2" ]` — a dead branch, since `-f` implies `-e`) was **already
fixed on darwin** by commit 258e93a, which added the `-L`-based check and
`ln -s -f` self-heal. That fix is not part of this change; the engine below
simply preserves the behavior it established.

## Non-goals

- Not merging the darwin/linux/desktop/laptop branches in this change (Phase 2).
- Not adding a templating or package-manager layer — this stays a symlink/copy
  linker, just hardened and data-driven.
- Not changing **what** gets linked or where. The manifest is a faithful
  transcription of darwin's current `link.sh` entry list.

## Phase 1 design

### Constraint

Only `/bin/bash` 3.2 is available on this machine (no homebrew bash, no
shellcheck) — no associative arrays, no `mapfile`. The manifest is therefore
a flat-file table read with `while read`, not a bash-4 data structure.

### `link.tsv`

A new tab-separated data file at the repo root, one row per entry:

```
<type>\t<source>\t<target>
```

- `type` is `link`, `copy`, or `dir`.
  - `copy` covers entries deliberately copied rather than symlinked, because
    they are seed files meant to be edited locally rather than kept in sync.
    On darwin today this is exactly one entry: `.gnupg/gpg-agent.conf`. It
    stays a distinct type rather than being special-cased, because the linux
    branch has copy-type entries too and Phase 2 merges these tables.
  - `dir` is for directories that must exist but aren't the parent of any
    linked or copied row — today only `~/.cache`, which is `mkdir -p`'d
    standalone for other tools. `dir` rows carry `-` in the source column.
- `source` is relative to `$DOTFILES_HOME`; `target` starts with a literal
  `~`. Unlike today's inline `link_file` calls, values read from the manifest
  via `while read` are plain data — bash does **not** tilde-expand them — so
  the engine expands a leading `~` to `$HOME` itself (a bash-3.2-safe `case`
  match) before use.
- **Every row carries all three fields.** A `dir` row uses `-` rather than an
  empty source column because tab is an IFS *whitespace* character: bash
  collapses adjacent tabs into one delimiter, so an empty middle field
  silently shifts the target into the source variable. This was caught during
  verification, not design — the first test run failed on it. The engine also
  rejects any row with an empty field, so the class of bug cannot recur
  silently.
- The file is named `link.tsv`, **not** `link.manifest`: the global gitignore
  inherits `*.manifest` from a Python template, which would have silently kept
  the file out of the repository. The script would then have worked on this
  machine and failed on every fresh clone with "manifest not found". Also
  caught during verification.
- Blank lines and `#`-prefixed comments are skipped, so the currently-disabled
  `flameshot` and `htop` entries stay as visible documented rows rather than
  commented-out code.
- Paths containing spaces (`Sublime Text`, `Package Control.sublime-settings`,
  `Application Support`) are literal tab-separated fields — no shell quoting
  needed inside the file, which removes the quoting noise from those lines.

### Engine (`link.sh`)

`link.sh` becomes a pure engine: read `link.tsv` line by line, and for
each row:

1. `mkdir -p` the target's parent directory automatically, eliminating the
   hand-maintained brace lists (gap 1 above).
2. Dispatch by `type`: `link` → `link_entry`; `copy` → `copy_entry`; `dir` →
   `mkdir -p "$target"` and stop.

`link_entry "$src" "$dst"` semantics:

| Situation | Action |
|---|---|
| `$dst` is a symlink already resolving to `$src` | no-op |
| `$dst` is a symlink resolving somewhere **else** | warn, relink to `$src` |
| `$dst` is a symlink but broken (`-L` && `! -e`) | self-heal: `ln -sfn` (preserves 258e93a's behavior) |
| `$dst` exists as a real file/dir (not a symlink) | back it up to `$dst.bak`, then relink (gap 2) |
| `$src` doesn't exist | warn and skip; never create a dangling link (gap 3) |

The wrong-target case is not in the original script, which treated any
resolving symlink as correct. Comparing the resolved path catches a target
left over from a prior layout (the zellij YAML→KDL move is exactly this).

The `.bak` backup is a single file overwritten on each run, not timestamped
history — the repo side is already versioned in git, so the backup only needs
to preserve the one pre-existing local file the run is about to displace.

`copy_entry` handles missing sources and parent directories the same way, but
additionally **compares contents first**: identical means no-op, and a
destination that differs is backed up before being overwritten. The original
script copied unconditionally, which would silently discard local edits to
`gpg-agent.conf` — the very file the copy type exists to allow editing. This
is a deliberate improvement over the previous behavior, not a transcription.

### Output and exit status

Routine per-entry status (`linked`, `copied`, `fixed broken`, `created dir`)
goes to **stdout**. Warnings and errors carry the icon and uppercase label
from the global instructions file and go to **stderr**, with ANSI color only
on a TTY and only when `NO_COLOR` is unset. A per-category summary prints at
the end, and the script exits non-zero if any entry was skipped or failed
(gap 4).

### Flags

- `-n` / `--dry-run`: print the action each row would take, performing no
  mkdir, link, copy, or backup.
- `-v` / `--verbose`: additionally print resolved absolute source/target paths.
  The per-row status line stays on regardless — it is the visibility this
  change exists to provide.

### Files touched

- `link.sh` — rewritten as the manifest-driven engine.
- `link.tsv` — new; replaces the inline `link_file` / `mkdir -p` calls.
- `docs/plans/2026-07-21-declarative-link-manifest.md` — this doc.

### Compatibility / breaking changes

Same files land in the same places. Behavior differences:

- A real file at a link target is now backed up to `<target>.bak` and replaced,
  where previously `ln -s` failed and the run continued silently.
- A missing source is now skipped with a warning instead of producing a
  dangling symlink.
- The script exits non-zero on partial failure where it previously always
  exited 0.
- Three directories are no longer created, all of them previously empty:
  `~/.config/flameshot` and `~/.config/htop` (their entries are disabled, but
  the old brace list created the directories anyway) and
  `~/.config/zellij/plugins` (left behind by the zellij KDL migration, which
  removed the `.wasm` plugin copying but not its `mkdir`). Re-enabling any row
  recreates its parent directory automatically.

Verified by running the previous script and the new engine into two scratch
homes and diffing the resulting trees: **every symlink and file is identical**,
and those three empty directories are the only difference.

### Testing

There is no test suite in this repo. Verification was manual, driven against
scratch `$HOME` directories — never the live `$HOME`, whose configs are the
very symlink targets this script manages.

18 assertions, all passing:

| Scenario | Asserted |
|---|---|
| Fresh run into an empty home | exit 0, 28 links, `~/.cache` created, stderr empty |
| Immediate re-run | exit 0, nothing relinked, 29 reported unchanged |
| Broken symlink at target | healed to point back at the repo |
| Real file at target | replaced, original contents preserved in `.bak`, warning on stderr |
| Symlink pointing elsewhere | relinked to the repo |
| Locally edited `gpg-agent.conf` | edit preserved in `.bak` rather than silently overwritten |
| `--dry-run` into an empty home | exit 0, zero filesystem entries created |

Also verified separately: missing source skips without creating a dangling
link and exits 1; a malformed row is rejected and exits 1; warnings go to
stderr while the summary stays on stdout; `NO_COLOR=1` emits no ANSI escapes;
`--verbose` adds resolved paths and is silent without the flag.

`pre-commit run --all-files` passes clean (exit 0, no files modified by hooks).
Note the repo's pre-commit config carries no shell linter, and `shellcheck` is
not installed on this machine, so the engine has had no static analysis beyond
`bash -n`.

## Phase 2 (future work — documented only, not implemented here)

Merge the darwin/linux (and desktop/laptop/etc.) branches around one shared
`link.tsv` + `link.sh` engine:

- Add an `os` column (`common` / `darwin` / `linux`) to the manifest; the
  engine filters rows by `uname -s` at run time.
- Shared dotfiles live once as `common` rows instead of being duplicated across
  every branch's script; each branch keeps only its OS-specific rows.
- This addresses the "what if we merge the repos" scenario directly: adding a
  shared dotfile becomes a one-line manifest change rather than an edit to N
  branch-specific scripts.
- Deferred because it touches every machine's dotfiles, not just this one, and
  deserves its own spec once the manifest shape has proven itself in practice.

Relevant context for whoever picks this up: the global `AGENTS.md` symlinked
into `~/.claude/CLAUDE.md` currently resolves to a **different** local clone
(`iagoalonsomrf/dotfiles-linux`, remote `iagoalonsomrf/dotfiles`) than this
repo (`ibLeDy/dotfiles`). Reconciling those two repos is part of the same
migration question and should be settled before or alongside Phase 2.

## Outcome

Implemented 2026-07-21 on branch `claude/link-manifest`.

Deviations from the design as first written, all found during verification:

- The manifest is `link.tsv`, not `link.manifest` — the global gitignore's
  `*.manifest` would have excluded it from the repository entirely.
- `dir` rows carry `-` instead of an empty source column, and the engine
  rejects rows with empty fields (tab is IFS whitespace; adjacent tabs collapse).
- `copy` entries compare contents and back up before overwriting, rather than
  copying unconditionally as the original did.
- `link` entries also detect a symlink pointing at the *wrong* target, which
  the original script treated as already-correct.

Not done, and deliberately left for a follow-up decision:

- **The cutover has not happened.** This branch is not merged, and `link.sh`
  has not been run against the live `$HOME`. See the attention section.
- The Sublime keymap entry links the OSX source to a `Default (Linux)`
  filename. Transcribed verbatim from the previous script; on macOS, Sublime
  reads `Default (OSX).sublime-keymap`, so this keymap is likely inert on this
  machine. Left unchanged because fixing it is a real behavior change, not a
  refactor — worth its own decision.

## ⚠️ Attention and behavior changes

- 🔵 **BEHAVIOR CHANGE**: a pre-existing real file at a link target is now
  backed up to `<target>.bak` and replaced; a missing source is skipped rather
  than producing a dangling link; the script exits non-zero when any row is
  skipped or fails (previously always 0).
- 🟠 **WARNING**: `link.sh` manages the live `$HOME` configs of the machine it
  runs on. All verification targeted scratch directories; the live `$HOME` has
  not been touched.
- 🛑 **BLOCKER** for considering this done: the cutover is a separate, explicitly
  confirmed step. Merging this branch does not apply it — someone must run
  `link.sh` against the real `$HOME`, ideally `--dry-run` first. Until then the
  machine still has whatever the previous script left behind.
- 🟠 **WARNING**: no shell static analysis. The repo's pre-commit config has no
  shell linter and `shellcheck` is not installed here; only `bash -n` ran.
- 🟠 **WARNING**: the Sublime keymap entry points the OSX source at a
  `Default (Linux)` target filename, carried over verbatim. It is probably
  inert on macOS and predates this change.
- No change to which files are linked or where they land, verified by diffing
  the trees both scripts produce.
