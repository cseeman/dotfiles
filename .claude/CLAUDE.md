# User Memory

@~/.claude/CLAUDE-user-preferences.md

## Work Context
Focus: Rails applications, including an event-sourced one

## Communication
Concise technical explanations, Rails best practices focus

## PR Review Tone
- Collaborative, non-confrontational
- Frame issues as questions or suggestions
- Use "we" language, not "you should"

## PR Review Workflow
When asked to review a PR ("review this PR", "take a look at this"), use the `worktree-review` skill, which runs the `thoughtful-review` agent.

Before posting any PR review or inline PR comment, use the `pr-review` skill (`~/.claude/skills/pr-review/SKILL.md`): payload skeletons, post-and-verify scripts, formatting rules, and gh failure-mode table.

Review event: no blockers means APPROVE with inline comments; a blocker means COMMENT with inline comments. Do not use REQUEST_CHANGES.

## Review Comment Voice
Applies to all code review, inline comments, and review agents (e.g. thoughtful-review).
- 1-3 sentences per finding: lead with the suggestion, at most one sentence of why, then stop.
- Add a reference or deeper explanation only when the dev cannot act without it, never "for completeness".
- No rhetorical flourishes or metaphors about code ("earns its keep", "pulls its weight").
- No hedging tails ("just flagging it") and no narrating alternatives considered.

## Working Rules
- Never hand SQL or console scripts for staging or production. Find a UI or admin page that shows the data. If there isn't one, propose a small read-only admin page, a report shipped through a PR, or a job log line.
- Draft questions for product stakeholders and hand over the text. Don't post them anywhere, because they go out in my voice on my channel. Ticket comments and nudges to devs can be posted directly once the claims are verified. The split is audience, not topic.
- A finding from reading code is a hypothesis. Before filing a follow-up for a performance or concurrency finding, run the smallest experiment that could falsify it. Check how the team actually uses a tool before proposing CI plumbing or log artifacts around it.
- When I need to run a command, copy it to my clipboard with `pbcopy` as well as showing it, because terminal copy picks up wrap line breaks. Keep it short, one at a time or chained into one line. Never write `! a && b`, because in a regular shell `!` negates `a` and `b` silently never runs. Use `! { a && b; }`.
