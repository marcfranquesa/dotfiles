---
name: code-comments
description: Use when changing or reviewing code comments, doc comments, or TODOs.
---

## Rule

Prefer clear names and structure over comments. Comment why a choice exists,
what constraint matters, or what is surprising. Do not restate obvious code.
Update or delete stale comments when code changes.

## Example

Use `TODO(auth): Replace mock clock with injectable time source.` for concrete
follow-up work; avoid TODOs that only say "clean up".
