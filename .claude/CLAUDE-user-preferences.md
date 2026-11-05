# User Memory - Personal Preferences

## Writing
Applies to code, docs, PRs, tickets, and messages.
- No emojis.
- No em dashes (—) or double hyphens (--) as punctuation. Use commas, hyphens, or rephrase.

## Code Style
- Prefer explicit over clever
- Minimize code comments. Comment only what the code cannot say: why this shape, what breaks without it, a constraint set elsewhere. Never restate the line.
- Comment length: two lines is the target, four the ceiling. Past that, rename the code or move the explanation into the commit message or PR body.
- One fact per comment. Cut the sentence that re-explains the previous one. No narrating rejected alternatives, no reassurance, no "note that".

## Git Workflow
- Branch names never carry a personal prefix (no `chris/`, no `christine/`). Use the ticket branch name (`<team>-NNNN-slug`) or, without a ticket, `feature/`, `fix/`, or `refactor/` plus a short slug. Never infer a naming convention from other developers' branches in the repo.
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
- Lead with WHY: the problem or motivation, in 1-2 sentences. A stack's first PR uses the longer form below.
- Business justification: 1-2 sentences on operational impact.
- Do NOT enumerate everything that changed. The commits and diff carry the what.
- Add technical notes only for context a reviewer cannot get from the diff: a non-obvious tradeoff, migration ordering, or a deliberately deferred follow-up.
- Link the Linear ticket. Omit any section that has nothing to say.
- In a stack, the first PR opens for a reader with no context: Background (a few short sentences on the project and the problem), How this fits (a numbered list with one line per PR, and what comes next), then a short This PR. If choices need checking, list them under "A few choices to check:" as a bold statement plus its reason. Later PRs can point back to the first.
- Read a description through before posting: short sentences, no insider shorthand, and each sentence flows from the last.
