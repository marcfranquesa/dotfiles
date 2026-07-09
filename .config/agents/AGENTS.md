# Shared Agent Guidance

## Python Environments

Do not install Python packages into system, Homebrew, distro, or other global
Python environments, including with `sudo pip`, `pip install --user`, or
`--break-system-packages`. Use the project's declared environment manager
first. For one-off Python tools, prefer `uvx` or `uv run --with ...`; for Pixi
projects, prefer `pixi run`.

## Working Defaults

- Do branch/PR work outside `main` in a temporary `/tmp` worktree; keep the primary checkout on `main` unless told otherwise.
- Use `/tmp` for temporary repo clones or inspection checkouts, and delete them when done.
- Prefer clear code over comments; keep comments for why, constraints, or surprising behavior, and update or delete stale comments.

## Cross-Model Review

- For non-trivial plans/designs/solutions, or risky or substantial changes, get
  a read-only second opinion from the other model family before finalizing. Skip
  if the other CLI is unavailable or blocked.
- Use the exact model settings below; do not downgrade them. Pass prompts
  through stdin/heredoc, never shell arguments. Use a delimiter that does not
  appear in the prompt. Provide file paths and a short summary; paste only
  relevant small diffs. Reviewers can inspect files but may not be able to
  reconstruct full diffs.

Codex -> Claude:

```sh
claude -p \
  --model fable \
  --effort high \
  --no-session-persistence \
  --permission-mode dontAsk \
  --tools Read,Grep,Glob <<'REVIEW_PROMPT'
<review prompt and concise context>
REVIEW_PROMPT
```

Claude Code -> Codex:

```sh
codex -a never exec \
  -s read-only \
  --ephemeral \
  -m gpt-5.5 \
  -c 'model_reasoning_effort="xhigh"' \
  - <<'REVIEW_PROMPT'
<review prompt and concise context>
REVIEW_PROMPT
```

Prompt examples: `Critique this implementation plan for hidden assumptions and
simpler alternatives:` or `Review the change to <paths> for correctness risks
and missing tests:`.
