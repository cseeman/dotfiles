# Development Workflow with Tmux + Claude Code

## Layout

Claude Code handles editing, git, tests, and server management directly, so
dedicated panes for each are no longer needed. The current layout pairs a shell
with Claude side by side:

```
┌─────────────────────────┬─────────────────────────┐
│                         │                         │
│   Shell                 │   Claude Code           │
│   (commands, server)    │   (AI pair programmer)  │
│                         │                         │
└─────────────────────────┴─────────────────────────┘
```

The shell pane is for anything you need hands-on control over (running a
server, quick one-off commands). Claude handles the rest: file editing, git
operations, test runs, and codebase exploration.

## Quick Setup Commands

### Manual Setup (from scratch)
```bash
# Create session
tmux new-session -s feature-name

# Split vertically (side by side)
Ctrl-t |    # Split into left and right panes

# Left pane: shell (ready for commands)
# Right pane: claude
```

### Using dev-session Script
```bash
# Symlink into your PATH (already configured)
ln -sf ~/Documents/Repos/dotfiles/dev-scripts/dev-session ~/bin/dev-session

# Usage: cd to your project, then run:
dev-session

# Or with custom session name:
dev-session my-session-name

# Or with specific directory:
dev-session session-name /path/to/project
```

## Git Worktree Workflow

### Creating Worktrees
```bash
# Option 1: Using bin/feature script (if available in current branch)
./bin/feature branch-name

# Option 2: Manual worktree creation
git worktree add ../qualify-feature-name existing-branch-name
cd ../qualify-feature-name
```

### Working with Existing Branches
```bash
# For branches like christine/add-event-factory
./bin/feature add-event-factory
# Creates: ../qualify-2025-08-15-add-event-factory/

# Or manually:
git worktree add ../qualify-event-factory christine/add-event-factory
```

## Essential Tmux Commands

### Navigation
- `Ctrl-t h/j/k/l` - Navigate panes (vim-style)
- `Ctrl-h/j/k/l` - Navigate panes (vim-tmux-navigator)
- `Ctrl-t z` - Toggle pane fullscreen
- `Ctrl-t c` - New window
- `Ctrl-t 1,2,3,4` - Switch windows

### Session Management
```bash
# List sessions
tmux list-sessions

# Attach to session
tmux attach-session -t session-name

# Detach (keeps running)
Ctrl-t d

# Kill session
tmux kill-session -t session-name
```

## Tmux Configuration

The tmux config lives in `~/.config/tmux/` with modular files for options,
keybindings, and themes. Key settings for this workflow:

- **Prefix**: `Ctrl-t` (instead of default `Ctrl-b`)
- **Pane navigation**: `Ctrl-h/j/k/l` (vim-style, integrates with vim-tmux-navigator)
- **Splits**: `|` for vertical, `-` for horizontal (preserves current path)
- **Popups**: `g` for lazygit, `f` for ranger, `h` for htop
- **Zoom**: `Ctrl-t z` to toggle full-screen on any pane
- **Mouse**: enabled

## Development Flow

### Pane Responsibilities
1. **Shell (left)** - Server processes, one-off commands, anything requiring
   direct terminal control
2. **Claude Code (right)** - Editing, git, tests, codebase exploration, and
   AI-assisted development

### Workflow Pattern
```bash
# 1. Claude pane (right) - ask Claude to implement, edit, or explore code
# 2. Shell pane (left) - start bin/dev, run a migration, check logs
# 3. Ctrl-t h/l to switch between panes
# 4. Ctrl-t z to zoom a pane for full-screen reading
```

### What Claude Handles Directly
- File editing (reads, writes, and diffs without needing a separate editor)
- Git operations (status, commits, branches, PRs)
- Running tests (`bundle exec rspec`, etc.)
- Codebase search and exploration
- Convention-aware code generation

## Git Aliases

The workflow supports your git aliases:
```bash
git st      # status
git pf      # push --force-with-lease
git can     # commit --amend --no-edit
git up      # pull --rebase --autostash
```

## Tips

### Session Persistence
Sessions survive sleep/wake cycles. Detach with `Ctrl-t d` and reattach anytime.

### Pane Management
- Use `Ctrl-t z` to zoom when reading longer Claude responses
- Resize panes based on current task
- Create multiple windows for different work (feature vs debugging)