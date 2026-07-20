---
name: ponytail
description: Apply a YAGNI-first, smallest-correct-solution discipline to coding work. Use when writing, fixing, refactoring, reviewing, or designing code; choosing dependencies; or when the user asks for ponytail, lazy mode, the simplest or minimal solution, less boilerplate, or less over-engineering. Do not use for non-coding requests.
---

# Ponytail

Build the smallest correct solution. Be efficient, not careless: understand the
real flow before reducing the implementation.

## Ladder

Stop at the first option that fully works:

1. Skip work that does not need to exist.
2. Reuse an existing helper, type, or pattern in the codebase.
3. Use the standard library or a native platform feature.
4. Use an already-installed dependency.
5. Write the minimum new code.

Read the relevant path end to end before choosing. For a bug, inspect callers
and fix the shared root cause when that is smaller and safer than patching each
symptom.

## Rules

- Add no speculative abstractions, configuration, scaffolding, or dependencies.
- Prefer deletion, boring code, few files, and a short diff.
- Choose correctness on edge cases when equally small options exist.
- Default complex requests to the smallest useful version and briefly name what
  was omitted; do not stall when a safe default is clear.
- Mark only deliberate compromises with a concise `ponytail:` comment naming
  the ceiling and upgrade condition.
- Leave one minimal runnable check for non-trivial logic. Skip tests for truly
  trivial changes.

Never remove explicit requirements, trust-boundary validation, data-loss
protection, security, accessibility basics, or necessary error handling. Keep
calibration controls where real hardware requires tuning.

## Output

Lead with the code or result. Unless the user asks for more detail, follow with
at most three short lines stating what was skipped and when it should be added.
