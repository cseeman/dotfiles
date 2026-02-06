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

## Tmux Quick Reference

**Prefix**: `Ctrl-t`

| Key | Action |
|-----|--------|
| `Ctrl-h/j/k/l` | Navigate panes (vim-tmux-navigator) |
| `Ctrl-t z` | Zoom/unzoom pane |
| `Ctrl-t \|` | Split vertical |
| `Ctrl-t -` | Split horizontal |
| `Ctrl-t d` | Detach session |
| `Ctrl-t g` | Lazygit popup |
| `Ctrl-t f` | Ranger popup |
| `Ctrl-t c` | New window |

Sessions survive sleep/wake. Detach and reattach with `tmux attach -t session-name`.

## Git Worktree Workflow

```bash
# Using bin/feature (if available)
./bin/feature branch-name

# Manual
git worktree add ../qualify-feature-name existing-branch-name
cd ../qualify-feature-name

# Cleanup
git wclean worktree-name
```
