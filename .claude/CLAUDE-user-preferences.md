# User Memory - Personal Preferences

## Code Style
- Prefer explicit over clever
- No emojis in code or documentation
- No em dashes (—) or double hyphens (--) as punctuation. Use commas, hyphens, or rephrase.
- Minimize code comments. Comment only what the code cannot say: why this shape, what breaks without it, a constraint set elsewhere. Never restate the line.
- Comment length: two lines is the target, four the ceiling. Past that, rename the code or move the explanation into the commit message or PR body.
- One fact per comment. Cut the sentence that re-explains the previous one. No narrating rejected alternatives, no reassurance, no "note that".

## Git Workflow
- Atomic commits: one logical change each. If the subject needs "and", split the commit.
- Amend small fixes into their parent commit; do not pile on "fix typo" commits.
- Build small, incremental PRs that stack. One concern per PR.
- Always create PRs as draft (`gh pr create --draft`)
- Do NOT add a Co-Authored-By: Claude trailer to commits
- Do NOT add "Generated with Claude Code" lines to commits or PRs

## Commit Messages
- The commit message is the WHY. Lead with intent and motivation, never a file-by-file recap.
- Subject: imperative, capitalized, no trailing period, 50 chars max (hook-enforced in qualify).
- Body is optional and rare. Add it only when the why needs a sentence of context the diff cannot show. Keep it to 1-3 lines wrapped at 72. Never a bullet list of what changed.
- The diff already shows WHAT changed. Do not restate it. Concise over conversational; non-confrontational in tone.

## Pull Request Descriptions
A PR description is not a changelog of the diff. Keep it short and focused.
- Lead with WHY: the problem or motivation, in 1-2 sentences.
- Business justification: 1-2 sentences on operational impact.
- Do NOT enumerate everything that changed. The commits and diff carry the what.
- Add technical notes only for context a reviewer cannot get from the diff: a non-obvious tradeoff, migration ordering, or a deliberately deferred follow-up.
- Link the Linear ticket. Omit any section that has nothing to say.
