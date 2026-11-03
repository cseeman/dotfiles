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

# Or manually
tmux new-session -s feature-name
Ctrl-t |    # Split side by side
```

Run from inside tmux, `dev-session` switches to the session instead of nesting.
If the session already exists, it attaches to it.

## Tmux Quick Reference

**Prefix**: `Ctrl-t`

| Key | Action |
|-----|--------|
| `Ctrl-h/j/k/l` | Navigate panes (vim-tmux-navigator) |
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
git worktree add ../project-feature-name branch-name
cd ../project-feature-name
dev-session                      # session named project-feature-name

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
