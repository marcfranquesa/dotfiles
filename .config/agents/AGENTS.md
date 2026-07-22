# Shared Agent Guidance

## Python Environments

Do not install Python packages into system, Homebrew, distro, or other global
Python environments, including with `sudo pip`, `pip install --user`, or
`--break-system-packages`. Use the project's declared environment manager
first. For one-off Python tools, prefer `uvx` or `uv run --with ...`; for Pixi
projects, prefer `pixi run`.

## Working Defaults

- Do branch/PR work outside `main` in a temporary `/tmp` worktree; keep the
  primary checkout on `main` unless told otherwise.
- Use `/tmp` for temporary repo clones or inspection checkouts, and delete them
  when done.
- Prefer clear code over comments; keep comments for why, constraints, or
  surprising behavior, and update or delete stale comments.

## GitHub Mutation Scope

- Before mutating multiple PRs, issues, branches, or worktrees, resolve their
  exact identifiers and authors or owners, then state the filtered target set.
- By default, mutate only PRs and issues authored by `marcfranquesa`, and only
  branches and worktrees created or actively worked on in the current thread,
  all within the user's explicit request. Repository or organization ownership,
  numeric ranges, and words such as "all" do not authorize third-party items.
- Treat third-party items as read-only unless the user explicitly names the
  exact item and requested mutation.

## Model Handoffs

- Hand off a task or subtask when another available model is materially better
  suited to it. Give the receiving model the artifact, audience, constraints,
  and success criteria; the primary agent remains responsible for integration,
  correctness, and verification.
- For substantial taste-driven visual work—including report and dashboard
  design, websites, presentations, visual identity, and UX—a non-Fable agent
  should hand off the design direction and at least one iteration to Fable when
  practical. Do this early enough for Fable to shape the result, rather than
  using it only for final review.
- This does not apply to routine report updates, plain-text summaries, or
  mechanical styling changes.

Examples:

- For an HTML experiment report, ask Fable to design or refine the information
  hierarchy, layout, typography, color, and figure presentation. The primary
  agent should implement it and verify the data and behavior.
- For a website or UX flow, ask Fable to establish the visual direction and
  critique rendered screenshots during iteration.

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
  -m gpt-5.6 \
  -c 'model_reasoning_effort="high"' \
  - <<'REVIEW_PROMPT'
<review prompt and concise context>
REVIEW_PROMPT
```

Prompt examples: `Critique this implementation plan for hidden assumptions and
simpler alternatives:` or `Review the change to <paths> for correctness risks
and missing tests:`.
