Status: Open

# SSH key alias reconciliation

## Context

2026-07-20: `~/.ssh/work` and `~/.ssh/personal` were added as convenience
symlinks alongside the canonical key files — `work -> <work key file>`,
`personal -> id_rsa` (and matching `.pub`s). This pairs with a git
`includeIf` key-routing change that made the personal key the default and
routed work repos to the work key.

## Problem

`ssh-add`ing the work key by its real filename auto-loads its matching
`<name>-cert.pub` (a symlink to a certificate issued by an internal
work certificate-management tool). `ssh-add ~/.ssh/work` does **not** load
a cert: confirmed directly — loading the key by its real name reports both
`Identity added` and `Certificate added`, while loading it via the `work`
alias reports only `Identity added`. `ssh-add` looks for an exact
`<path>-cert.pub` next to whatever path it's given, and `work-cert.pub`
doesn't exist.

**Current impact is small.** `~/.ssh/config`'s `Host` blocks for work
infrastructure already reference the key by its real name directly, not
`work` — nothing configured today is broken. It only bites if `work` is
used somewhere that expects full cert-based access to that infrastructure.

## Options

1. **Cheapest fix:** add `work-cert.pub -> <the real cert file>` (mirrors
   the existing `work.pub` symlink), making the `work` alias fully
   cert-capable.
2. **Cross-machine `id_rsa` compatibility:** if a tool on another machine
   hardcodes `~/.ssh/id_rsa` with no override, prefer pointing that tool's
   `IdentityFile` at the real key explicitly over symlinking
   `id_rsa -> work`. `id_rsa` is one of ssh's automatic default identities —
   a bare symlink there means ssh may offer that key to *any* host unless
   every relevant `Host` block already sets `IdentitiesOnly yes`. If the
   tool genuinely can't take an explicit path, the symlink is an acceptable
   narrow fallback with that trade-off understood.
3. Renaming the canonical work key/cert to `work` was considered and
   rejected as the primary approach — not because it's blocked, but because
   it's unnecessary churn for no benefit over option 1. If it's ever done,
   the cert symlink just needs repointing to wherever the internal cert
   tool keeps the certificate; that's not a hard dependency, just a step to
   redo.

## Remaining work

- [ ] Decide whether to reconcile now (option 1) or leave as-is until `work`
      is actually used for cert-dependent access.
- [ ] If reconciling, add the `work-cert.pub` symlink and verify
      `ssh-add ~/.ssh/work` reports `Certificate added`.
