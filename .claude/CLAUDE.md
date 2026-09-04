# User Memory

@~/.claude/CLAUDE-user-preferences.md

## Work Context
Focus: Rails applications with event-sourced architectures

## Communication
Concise technical explanations, Rails best practices focus

## PR Review Tone
- Collaborative, non-confrontational
- Frame issues as questions or suggestions
- Use "we" language, not "you should"
- REQUEST_CHANGES only for genuine blockers

## PR Review Workflow
Before posting any PR review or inline PR comment, use the `pr-review` skill (`~/.claude/skills/pr-review/SKILL.md`): payload skeletons, post-and-verify scripts, formatting rules, and gh failure-mode table.

## Review Comment Voice
Applies to all code review, inline comments, and review agents (e.g. thoughtful-review).
- 1-3 sentences per finding: lead with the suggestion, at most one sentence of why, then stop.
- Add a reference or deeper explanation only when the dev cannot act without it, never "for completeness".
- No rhetorical flourishes or metaphors about code ("earns its keep", "pulls its weight").
- No hedging tails ("just flagging it") and no narrating alternatives considered.
