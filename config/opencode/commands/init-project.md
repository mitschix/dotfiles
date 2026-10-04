---
# source: original, inverted from a gsd-core / kickstart.opencode style project-scan.
# Those enumerate manifests and transcribe them into AGENTS.md, which is how a 40-line
# AGENTS.md becomes a stale 400-line one. This does the opposite: find what is already
# knowable, and record only what reading the repo cannot tell you.
description: Generate or update AGENTS.md from what the repo cannot tell a reader.
---

Build or update `AGENTS.md` for this project$ARGUMENTS.

## What to write

Record only what someone **cannot** derive by reading the repository:

- Commands that actually work here, with their real invocation.
- Conventions this project follows that differ from the norm.
- Constraints, dead ends, and things that look wrong but are deliberate.
- Anything enforced by tooling that would otherwise be discovered the hard way.

## What never to write

Everything the repository already states, because it will go stale the moment the
repo changes:

- Language, framework, package manager, or runtime versions.
- Dependency lists, directory trees, file inventories.
- Build config, CI definitions, linter settings.
- Anything a manifest, lockfile, config file, doc, or commit message already says.

Read the manifests to *learn the commands*; never transcribe the manifests. If you
cannot tell whether a fact is derivable, it is derivable - leave it out.

## Method

1. Read the existing `AGENTS.md` first, if there is one. Preserve the author's voice,
   structure, and anything already there.
2. Find the real commands. Look at the task runner, Makefile, scripts, CI workflow, and
   the pre-commit config. Prefer what CI runs over what the README claims.
3. Look for project-level instructions and docs - `CONTRIBUTING.md`, `docs/`,
   `README.md`, nested `AGENTS.md`.
4. Check recent history for conventions and for reverted approaches:
   `git log --oneline -40`.
5. Draft the delta. Keep it short. If the existing `AGENTS.md` already covers something,
   do not duplicate it.

## Before writing

Show the proposed content and state plainly whether it is a new file, a replacement, or
an append. Ask before writing. Never overwrite an existing `AGENTS.md` without explicit
confirmation.

## Target shape

One page. Prose over lists of rules. Specific over general - "run `./install-standalone
nvim` to bootstrap, it needs network access" beats "follow the setup docs". If the
draft exceeds roughly 80 lines, the project probably has nothing non-obvious to say
yet; say that instead of padding it.