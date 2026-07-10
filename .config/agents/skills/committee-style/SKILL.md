---
name: committee-style
description: Use only when the user explicitly asks for "committee style", "committee review", "panel review", "many subagents", "multi-agent critique", or several independent reviewers. Runs a scalable committee of subagents with distinct perspectives, local artifact coverage, and synthesized findings. Do not trigger for ordinary review, editing, planning, or "think carefully" requests.
---

# Committee Style

Use this skill only for an explicit committee-style request. The point is independent criticism from multiple agents, not one agent roleplaying voices.

## Core Contract

Complete at least five independent review passes. Five is the floor. Use true subagents where available, but run them in bounded waves instead of assuming all reviewers can be open at once. Close completed agents before starting later waves, and start a fresh reviewer in each freed slot until the floor is met. Scale above five only when distinct surfaces or failure modes justify it: 6-8 for medium artifacts, 9-12 for large artifacts, and multiple waves for very large artifacts.

Use a hybrid committee: whole-artifact perspective reviewers, slice reviewers for local surfaces, and a holistic reviewer when integration matters. Avoid a role-by-slice cross product unless the user asks or the artifact is tiny and high-stakes.

Keep reviewers independent until synthesis. The coordinator deduplicates by root cause, ranks by severity and relevance, and applies changes only if the user asked for changes.

If a spawn fails because the runtime is at its concurrent-agent limit, keep the successful reviewers, do local non-overlapping coordination work while they run, then close finished agents and continue the next wave. If true subagents are unavailable at all, say so and run at least five clearly labeled single-agent review passes as a fallback. Do not present that fallback as a real committee.

## Usage References

Before choosing reviewer roles, read the matching reference file:

- writing, prose, docs, memos, grants, or essays: `references/writing.md`;
- code, PRs, diffs, modules, APIs, tests, or security: `references/code.md`;
- research, math, technical papers, proofs, experiments, or citations: `references/papers.md`;
- plans, designs, roadmaps, product proposals, or process proposals: `references/plans-designs.md`.

If the task spans domains, read each relevant reference. If no domain fits, use the core workflow without loading extra references.

## Workflow

1. Identify artifact type, scope, audience, goal, and review surfaces.
2. Read relevant usage references and choose roles/scopes.
3. Spawn reviewers in parallel where possible, using bounded waves when slots are limited. Give each reviewer a role, scope, source material, and output format.
4. Ask for concise findings: location, severity, issue, consequence, smallest concrete fix, and confidence.
5. Synthesize by root cause. Prefer evidence over vote count, keep only decision-relevant disagreements, and discard low-actionability comments.
6. If edits are requested, apply selected fixes and verify.

Tell reviewers not to summarize, praise by default, list generic best practices, or read other reviewers' findings before finishing.

## Output

Use this structure unless the user asks otherwise:

1. Committee setup: roles and scopes.
2. Top findings: deduplicated and ranked.
3. Decision-relevant disagreements.
4. Recommended or applied changes.
5. Verification and remaining gaps.

Apply domain-specific prioritization from the loaded references before formatting the final output.

Do not include raw subagent transcripts unless asked.
