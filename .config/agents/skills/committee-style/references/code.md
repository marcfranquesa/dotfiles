# Code Reviews

Use this reference for code, PRs, diffs, modules, APIs, tests, security, performance, and maintainability reviews.

## Reviewer Roles

- correctness/risk reviewer;
- architecture/API reviewer;
- test reviewer;
- security/performance reviewer;
- partition reviewer for assigned files, functions, modules, or workflows;
- simplicity reviewer;
- holistic integration reviewer.

## Coverage

Assign slice reviewers to disjoint files, functions, modules, or workflows when the change is larger than one narrow area.

Tell reviewers to inspect the actual code, tests, logs, docs, and contracts available to them. Findings should cite concrete files, lines, commands, or observed behavior where possible.

## Synthesis

Lead with bugs, regressions, risks, and missing tests. Rank style and architecture concerns below behavior unless they create real maintenance or user-facing risk.

If edits are requested, keep write scopes coordinated and tell workers not to revert unrelated user or reviewer changes.
