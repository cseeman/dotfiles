# Personal scripts

`~/bin` is a symlink to this directory, so everything here is on PATH.

## tmux-sessionizer

`prefix + j` in tmux opens an fzf list of every directory under
`~/Documents/Repos` (repos and sibling worktrees) and jumps to that project's
`dev-session`, creating it on first use. Set `TMUX_SESSIONIZER_ROOTS` to a
colon-separated list to look elsewhere.

## git-recent

`git recent [n]` lists local branches by last commit, newest first, sized to
the terminal when no count is given. `git recents`, `recent5`, and `recent10`
are aliases onto it.

# Dev Session - Tmux + Claude Code

## Layout

```
┌─────────────────────────┬─────────────────────────┐
│                         │                         │
│   Shell                 │   Claude Code           │
│   (commands, server)    │   (AI pair programmer)  │
│                         │                         │
└─────────────────────────┴─────────────────────────┘
```

## Setup

```bash
# Using the script (cd to your project first)
dev-session

# With custom session name or directory
dev-session my-session-name
dev-session session-name /path/to/project

# In the branch's own worktree, created beside the repo if needed
dev-session -w feature-name

# Or manually
tmux new-session -s feature-name
Ctrl-t |    # Split side by side
```

Each worktree gets one session, named after its directory, so the name stays
true when the branch changes. Run from inside tmux, `dev-session` switches to the
session instead of nesting. If the session already exists it attaches, and says
so when that session lives in a different directory.

## Tmux Quick Reference

**Prefix**: `Ctrl-t`

| Key | Action |
|-----|--------|
| `Ctrl-h/j/k/l` | Navigate panes (vim-tmux-navigator); `Ctrl-j` stays with Claude |
| `Ctrl-t z` | Zoom/unzoom pane |
| `Ctrl-t \|` | Split side by side |
| `Ctrl-t -` | Split top and bottom |
| `Ctrl-t c` | New window |
| `Ctrl-t d` | Detach session |
| `Ctrl-t j` | Jump to a project session (fzf) |
| `Ctrl-t T` | Theme picker |
| `Ctrl-t t` | Toggle status bar |
| `Ctrl-t P` | Paste tmux buffer |
| `Ctrl-t h` / `Ctrl-t i` | htop / irb popup (htop needs installing) |
| `Ctrl-t f` | Ranger popup (needs installing) |
| `Ctrl-t r` | Reload config |
| `Ctrl-t M` | Edit tmux.conf in a split |
| `Alt-[` / `Alt-]` | Swap pane down / up |

Sessions survive sleep/wake. Detach and reattach with `tmux attach -t session-name`.

## Git Worktree Workflow

```bash
cd project
dev-session -w feature-name      # worktree and session project-feature-name

git wclean ../project-feature-name   # remove worktree, delete its branch if merged
```

## pr-waiting

`pr-waiting` lists open PRs across your configured repos that are still
waiting on a review from you, oldest first, flagging the ones that touch an
architectural surface (ADRs and migrations by default).

Review requests in these repos land on teams, not individuals, and GitHub
does not clear a team request once a teammate reviews. The raw list is
therefore mostly noise, so by default the script drops drafts, bot-authored
PRs, and anything you have already reviewed.

| Flag | Effect |
|------|--------|
| `--all` | No filtering, the raw team queue |
| `--drafts` | Include draft PRs |
| `--json` | Machine-readable output |

Work-specific values live in the untracked `~/.pr-tools.local`, which the
PR scripts source:

```bash
PR_WAITING_REPOS=${PR_WAITING_REPOS:-"your-org/app-one your-org/app-two"}
PR_WAITING_SURFACES=${PR_WAITING_SURFACES:-'^(docs/adr/|db/migrate/|app/graphql/)'}
PR_REREVIEW_ORG=your-org
```

`PR_WAITING_REPOS` is required. The `${VAR:-...}` form lets a value set for
one run win over the file. `PR_WAITING_USER` overrides the GitHub login.

## pr-rereview

`pr-rereview` lists open PRs you reviewed that may need another look: not yet
approved, or re-requested since you approved. Each shows what changed since your
last review, most urgent first. `pr-rereview-notify` runs it on weekday mornings
through the launch agent in `launchd/` and only notifies when something needs you.
Pass an org, or set `PR_REREVIEW_ORG` in `~/.pr-tools.local`.

## my-prs

`my-prs` lists your open and draft PRs across an org, grouped by repo, with
state, review decision, and CI (`green`, or the non-green conclusions with
counts). `--raw` prints `|`-separated rows with dates and URLs instead, for the
`my-prs` skill. Pass an org, or set `PR_REREVIEW_ORG` in `~/.pr-tools.local`. To
track someone else's PR alongside yours, add `owner/repo#number` lines to
`~/.my-prs-extras` (or the file named by `PR_MINE_EXTRAS`); each shows until it
merges or closes.

## pr-surfaces

`pr-surfaces` shows where your PR attention went across your configured repos,
month by month: how much you authored, how much you reviewed, and how much of
each touched an architectural decision surface.

Reviews bucket on the date you submitted the review. GitHub search has no
date qualifier for review events, so a monthly count taken from search alone
silently buckets by the PR's open date instead, which is a different number.

| Flag | Effect |
|------|--------|
| `--months N` | Window size, default 6, snapped to month boundaries |
| `--json` | Machine-readable output |

Shares `PR_WAITING_REPOS`, `PR_WAITING_SURFACES`, and `PR_WAITING_USER` with
`pr-waiting`. Takes about 30s, since it walks every page of both searches.
