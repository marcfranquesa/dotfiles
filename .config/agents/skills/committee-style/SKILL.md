---
name: committee-style
description: Use only when the user explicitly asks for "committee style", "committee review", "panel review", "many subagents", "multi-agent critique", or several independent reviewers. Runs a scalable committee of subagents with distinct perspectives, local artifact coverage, and synthesized findings. Do not trigger for ordinary review, editing, planning, or "think carefully" requests.
---

# Committee Style

Use this skill when the user explicitly wants a committee-style review. The point is fresh, independent criticism from multiple agents, not one agent roleplaying several voices.

## Core Rule

Spawn at least five independent subagents. Five is the floor, not the cap.

Use more agents when there are real independent surfaces to inspect: paragraphs, sections, files, functions, modules, claims, proofs, experiments, APIs, workflows, audiences, or risk categories.

The main agent coordinates. Subagents critique or inspect. The main agent synthesizes, deduplicates, decides what matters, and applies changes only if the user asked for changes.

If true subagents are unavailable, say so and run at least five clearly labeled single-agent review passes as a fallback. Do not present that fallback as a real committee.

## Sizing

- 5 agents: smallest valid committee; short or narrow artifacts only.
- 6-8 agents: normal for medium drafts, meaningful code changes, plans, or research sections.
- 9-12 agents: large drafts, full PRs, multi-module code, or technical paper sections.
- More than 12 agents: allowed for very large artifacts; use review waves with clear scopes.

Do not stop at five just because five is allowed. Add agents when they cover distinct material or distinct failure modes. Do not add agents whose work would substantially duplicate existing reviewers.

## Shape

Use a hybrid committee:

- perspective reviewers inspect the whole artifact through different lenses;
- slice reviewers inspect assigned paragraphs, sections, files, functions, modules, claims, tests, or workflows;
- holistic reviewers check whether the full artifact works together;
- the main agent merges the results.

Do not use a full expert-by-paragraph or expert-by-function cross product unless the user explicitly asks or the artifact is tiny and high-stakes.

## Role Menus

For writing:

- formal rigor reviewer;
- narrative/flow reviewer;
- technical/content reviewer;
- local paragraph or section editor;
- skeptical reader;
- audience/venue reviewer;
- holistic editor.

For code:

- correctness/risk reviewer;
- architecture/API reviewer;
- test reviewer;
- security/performance reviewer;
- partition reviewer for assigned files/functions/modules;
- simplicity reviewer;
- holistic integration reviewer.

For research, math, or papers:

- proof/technical checker;
- framing/novelty reviewer;
- venue editor, if a target venue is known: fit, standards, editorial framing, acceptance bar;
- venue reviewer, if a target venue is known: likely reviewer objections, expectations, missing evidence;
- reader/narrative reviewer;
- evidence/citation reviewer;
- local section/theorem/experiment reviewer;
- skeptical Reviewer 2;
- holistic argument reviewer.

For plans or designs:

- feasibility reviewer;
- simplicity/scope reviewer;
- risk reviewer;
- user-outcome reviewer;
- integration/sequencing reviewer;
- domain reviewer.

## Workflow

1. Identify artifact type, scope, audience, and user goal.
2. Map the review surfaces: sections, paragraphs, claims, files, functions, tests, proofs, workflows, or risks.
3. Choose committee size from coverage needs, starting at five and scaling upward.
4. Spawn reviewers in parallel where possible. Give each one a role, scope, source material, and output format.
5. Keep reviewers independent until they finish.
6. Synthesize by root cause, not by reviewer.
7. Rank findings by severity, confidence, and relevance to the user goal.
8. If edits are requested, apply the selected fixes and verify.

## Subagent Output

Ask reviewers for concise actionable findings:

- location;
- severity: blocker, major, minor, optional;
- issue;
- consequence;
- smallest concrete fix;
- confidence: high, medium, low.

Tell reviewers not to summarize, praise by default, list generic best practices, or read other reviewers' findings before completing their own pass.

## Synthesis

The main agent must:

- deduplicate by root cause;
- prefer evidence over vote count;
- preserve disagreements only when they affect the decision;
- discard speculative or low-actionability comments;
- distinguish review opinion from verified facts, tests, logs, renders, citations, or source evidence.

Do not emit duplicate findings for the same bug, the same missing test, or the same underlying API/maintainability issue.

## Output

Use this structure unless the user asks otherwise:

1. Committee setup: roles and scopes.
2. Top findings: deduplicated and ranked.
3. Decision-relevant disagreements.
4. Recommended or applied changes.
5. Verification and remaining gaps.

For code, lead with bugs, regressions, risks, and missing tests. For writing, lead with claim-level and structure-level issues before wording polish, and include proposed changes for the important issues.

Do not include raw subagent transcripts unless asked.

## Guardrails

- Five reviewers is the floor.
- Scale above five when independent coverage justifies it.
- Add agents for coverage, not decoration.
- Keep agents independent until synthesis.
- Avoid consensus theater; the coordinator decides, not the vote count.
- Avoid runaway loops: one committee pass plus one final check is enough unless there is a blocker, major disagreement, new evidence, or explicit user request.
- For code edits, use disjoint write scopes and tell workers not to revert others' changes.
