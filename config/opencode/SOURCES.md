# Provenance and maintenance

Where every agent, skill and command in this directory came from, and how to keep them
current. Read this before adding a fourth source.

## The rule

> **Own the prose. Consume the mechanism.**

If an artifact is a markdown file that changes behaviour by being read into a prompt,
vendor it here. If it registers hooks, transforms, watchers or state, install it as a
plugin.

Reasoning, so this does not get re-litigated:

- The customisation *is* the model routing. No upstream ships `qwen3.8-flash` for review
  and `glm-5.3` for architecture. Installed as a plugin we would have to patch it anyway,
  which is forking with a worse diff.
- These sources churn. Every one of them shipped breaking changes within a few months of
  release. "Update the plugin" is not free; it means reading changelogs and re-validating
  routing. For a 700-byte behaviour nudge there is nothing to re-validate.
- Plugins compete for namespace and each injects its own always-on system content. Local
  files merge cleanly.
- Installing a plugin to obtain markdown means installing the machinery around it:
  oh-my-opencode-slim is 7.5 MB of TypeScript plus 41 MB of companion binaries for one
  4.6 KB skill.

## Vendored files

Attribution: Apache-2.0 requires a NOTICE file when you redistribute; MIT requires the
copyright notice. These configs are personal, but if they ever ship, carry the notice.

| File | Source | SHA | Licence | Fidelity |
| --- | --- | --- | --- | --- |
| `agents/oracle.md` | omo-slim `role-prompts.ts` + `role-routing.ts` | `ba9af2dd86eb` | MIT | trimmed |
| `agents/fixer.md` | omo-slim `src/agents/role-prompts.ts` | `ba9af2dd86eb` | MIT | trimmed |
| `agents/review.md` | gsd-core `gsd-core/contexts/review.md` | `b5dc98a4c748` | MIT | trimmed |
| `agents/silent-failure-hunter.md` | ECC `agents/silent-failure-hunter.md` | `ef648e01899b` | MIT | trimmed |
| `skills/investigate-first/SKILL.md` | caveman | `6571943370f7` | Apache-2.0 | verbatim |
| `skills/verify-and-stop/SKILL.md` | caveman | `6571943370f7` | Apache-2.0 | verbatim |
| `skills/simplify/SKILL.md` | omo-slim `src/skills/simplify/SKILL.md` | `ba9af2dd86eb` | MIT | trimmed |
| `commands/init-project.md` | original (inverted) | - | - | new |

Every vendored file carries its source and SHA in a YAML comment in its frontmatter, so
the table can be regenerated rather than hand-maintained.

### Local edits worth knowing about

These are deliberate divergences from upstream. Do not "restore" them without reading why.

- **`oracle.md`** — kept the delegate / don't-delegate contract, which is the part most
  orchestration setups omit and the reason the orchestrator over-delegates.
- **`fixer.md`** — removed the orchestrator framing; there is no orchestrator here.
- **`review.md`** — dropped gsd-core's `<structural_findings>` (fallow) block. It is
  injected by gsd-core, which we do not run.
- **`silent-failure-hunter.md`** — dropped the `tools:` frontmatter field. It is a V1
  field and V2 rejects it; `permissions` replaces it. Also dropped ECC's "Prompt Defense
  Baseline", now covered once in `AGENTS.md` for every agent instead.
- **`simplify`** — dropped "Guidance for This Repository" (repo-local TypeScript advice
  inside a generic skill) and the trailing verification section, which duplicated the
  evidence rule in `AGENTS.md`.

## Plugins

| Plugin | Why a plugin and not vendored |
| --- | --- |
| `@dietrichgebert/ponytail` | Real runtime state: `/ponytail lite\|full\|ultra` persists a mode that the context hook reads. Cannot be expressed as static prose. |
| `opencode-snip@next` | Shell-output redaction is a real parse over tool output. `@next` is the v2 branch; `main` is V1-only and will not load. |

## Re-checking upstream

There is no sync script and there should not be. Check by hand, and only for files
marked *verbatim* — those are the only ones where upstream has anything to give.

```sh
curl -sL https://raw.githubusercontent.com/juliusbrussee/caveman/main/skills/investigate-first/SKILL.md \
  | diff - skills/investigate-first/SKILL.md
```

Worth a look roughly quarterly. Do not adopt upstream changes to *your* AGENTS.md rules —
those encode your standards, not theirs, and an upstream "improvement" would be a
regression.

## Traps hit while building this

Recorded because each cost real time and none is obvious from the result.

- **Agent permissions override global ones.** The docs say global `permissions` apply
  *before* agent rules, and the last matching rule wins. A `{action: read, resource: "*",
  effect: allow}` inside an agent file therefore lands *after* the global secrets
  blacklist and re-opens it. The deny-all-then-allow pattern is unsafe here. Vendored
  agents deny only their own lane (`edit`, `subagent`, `question`) and leave `read` to the
  global block.
- **V1 frontmatter fields are not silently ignored.** `tools`, `permission`, `maxSteps`,
  `temperature`, `disable` are all invalid in V2 agent config.
- **A custom agent defaults to `mode: primary`.** Subagents must say `mode: subagent`
  explicitly or they clutter the primary agent list.
- **Builtin agents already ship a permission policy.** The docs list it per agent:
  `build` allows questions; `plan` allows questions but denies edits outside
  `~/.opencode/plan`; `general` denies questions and subagents; `explore` denies
  everything except `read`/`glob`/`grep`/`webfetch`/`websearch`; `title`, `summary`
  deny all. **Check this before writing permission rules for a builtin.** A vendored
  `explore.md` was written and deleted for exactly this reason — all three of its deny
  rules duplicated the shipped policy, leaving only a model override, which is three
  lines of config in `opencode.jsonc`. Setting `agents.explore.model` merges with the
  builtin permissions; it does not replace them.
- **Compaction uses the session model.** There is no separate compaction model, so on
  `kimi-k2.7-code` ($4.00/M output) a large summary costs real money. This is the main
  argument for keeping the always-on prompt small.
- **`instructions` is currently a no-op in V2.** The schema accepts the array but V2 does
  not resolve the files, globs, or URLs, so nothing reaches the model. The key is kept
  in `opencode.jsonc` deliberately pending V2 support: do not assume it is live, and do
  not delete it on the assumption that it is dead.
- **Builtin commands are not in the docs.** `/compact` exists and works even though the
  commands page never lists it. Check the TUI before assuming a command must be built.

## Deliberately not adopted

Recorded so the same evaluation does not get repeated.

| Candidate | Why not |
| --- | --- |
| oh-my-opencode-slim (plugin) | Replaces agent routing wholesale and re-implements what the vendored prompts already do. Orthogonal to context management, not a magic-context substitute. Its `EXPLORER_PROMPT` was vendored and then dropped once the builtin agent's shipped permissions turned out to cover it. |
| vendored `explore.md` | Superseded by a 3-line `agents.explore.model` override in `opencode.jsonc`. The builtin's read-only boundary is already enforced; only the model was worth changing. |
| superpowers | 15 skills, largest 32.5 KB, plus an always-on bootstrap injection. `verification-before-completion` and `receiving-code-review` were absorbed into `AGENTS.md`; the rest duplicated rules already here. |
| caveman gateway / engine | Rewires provider config through a proxy. Its own `HONEST-NUMBERS.md` retracts the 75% token claim and documents net-loss cases. |
| ECC `rules/common/*` | Arbitrary numeric thresholds (<50-line functions, <800-line files, <4 nesting). Contradicts the KISS stance in `AGENTS.md`. |
| ECC `code-simplifier.md` | Duplicated `AGENTS.md` verbatim. Superseded by the `simplify` skill, which has the over-simplification guardrails ECC lacked. |
| `expert.md`, `autonomous.md` agents | Both duplicated `oracle.md` and the existing `build` agent respectively. |
| `surgical-patch`, `safe-refactor` skills | Unique content was 2-3 lines each; absorbed into the fix-discipline rule in `AGENTS.md`. |
| `verification-planning` skill | Same intent as the evidence rule, 10x the size. Its best line — build the smallest affordance that makes the state observable — is in `AGENTS.md`. |
| gsd-core `honest-verifier`, `untrusted-input-boundary` | Absorbed as rules rather than kept as separate reference files. |
| opencode-arise explorer prompt | Path no longer exists upstream; omo-slim's explorer prompt is better structured and served as the source instead. |
| `@kkchengg/opencode-redact` | Only v2-capable redaction plugin found, unaudited, 0 stars. Not worth it for credential handling. Native permissions already cover the block case. |
