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

git wclean ../project-feature-name   # remove worktree, delete branch, prune
```
