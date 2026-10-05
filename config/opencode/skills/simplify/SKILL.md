---
# source: alvinunreal/oh-my-opencode-slim @ ba9af2dd86eb · src/skills/simplify/SKILL.md
# trimmed: removed "Guidance for This Repository" (repo-local TypeScript advice inside a
#   generic skill) and the "Final-state verification" section (duplicates the evidence
#   rule in AGENTS.md).
name: simplify
description: Simplifies code for clarity without changing behavior. Use for readability, maintainability, and complexity reduction after behavior is understood.
---

# Code simplification

Reduce complexity while preserving exact behavior. The goal is not fewer lines - it is
code that is easier to read, understand, modify, and debug.

Pass test: would a new team member understand this faster than before?

## When to use

- A feature works but the implementation feels heavier than it needs to be.
- Review flagged readability or complexity.
- Deeply nested logic, long functions, unclear names.
- Code written under time pressure.
- Related logic scattered across files, or duplication after a merge.

**When NOT to use**:

- Already clean - do not simplify for its own sake.
- You do not understand it yet - comprehend first.
- Performance-critical and the simpler version is measurably slower.
- You are about to rewrite the module anyway.

## Principles

### 1. Preserve behavior exactly

Only change how the code expresses itself. Inputs, outputs, side effects, error
behavior, and edge cases must be identical. If you are not sure a change preserves
behavior, do not make it.

### 2. Follow project conventions

Simplification means more consistency with the codebase, not your own preferences.
Read `AGENTS.md`, study how neighbouring code handles the same pattern, and match it
for naming, imports, error handling, and style. Simplification that breaks project
consistency is churn.

### 3. Prefer clarity over cleverness

Explicit beats compact when compact needs a mental pause to parse. Replace nested
ternaries with control flow. Name intermediate steps when it clarifies intent. Keep
helpful names even at a few extra lines.

### 4. Maintain balance

Over-simplification is a real failure mode:

- Do not inline away names that carry meaning.
- Do not merge unrelated logic into one larger function.
- Do not remove abstractions that serve testability.
- Do not optimize for line count over comprehension.

### 5. Scope to what changed

Default to recently modified code. No drive-by refactors unless explicitly asked.

## Process

**Understand before touching.** What is this responsible for? What calls it? What does
it call? What are the error paths? Why might it have been written this way? If you
cannot answer, read more.

**Find the opportunities.** Deep nesting, mixed-responsibility functions, nested
ternaries, boolean flag arguments, repeated conditionals, misleading names, duplicated
logic, dead code, wrappers that add nothing.

**Apply incrementally.** One simplification at a time. Keep it only if the evidence
says behavior held. Separate refactoring from feature work.

**Confirm.** Genuinely easier to understand, clean diff, conventions still match, no
behavior or side-effect change.