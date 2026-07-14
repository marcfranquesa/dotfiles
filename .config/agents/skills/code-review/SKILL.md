---
name: code-review
description: Review code changes for correctness, regressions, security risks, and missing tests. Use when the user asks to review a diff, commit, branch, pull request, or implementation.
---

# Code Review

Review and report only; do not modify code unless asked.

Identify the exact review target and its correct base. Read the stated purpose
and relevant surrounding code, then review only the changes in scope.

Check:

- Correctness, including edge cases and error paths.
- Regressions to existing callers, interfaces, configuration, or behavior.
- Tests for new and changed behavior, and whether relevant checks pass.
- Security, privacy, and data-loss risks when relevant.
- Duplication of existing code and unnecessary complexity.
- Abstractions: reuse existing ones and introduce the minimum number and layers
  needed. Require each new abstraction to have at least two concrete uses unless
  it enforces a clear boundary or invariant; reject one-use wrappers and
  speculative extension points.

Report actionable findings first, ordered by severity. For each finding, cite
the relevant file and line and explain the concrete failure or impact.
Distinguish defects from optional suggestions. If there are no findings, say so
and mention any tests not run or remaining uncertainty.
