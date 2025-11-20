# Development Workflow with Tmux + Claude Code

## 4-Pane Tmux Layout

```
┌─────────────────────────┬─────────────────────────┐
│ Pane 0: Neovim         │ Pane 1: Claude Code     │
│ (editing code)          │ (AI assistance)         │
├─────────────────────────┼─────────────────────────┤
│ Pane 2: Git/Tests      │ Pane 3: Rails server    │
│ (git st, lazygit)      │ (bin/dev, watching logs)│
└─────────────────────────┴─────────────────────────┘
```

## Quick Setup Commands

### Manual Setup (from scratch)
```bash
# Create session
tmux new-session -s feature-name

# Split into 4 panes
Ctrl-b "    # Split horizontally
Ctrl-b k    # Move to top pane
Ctrl-b %    # Split vertically (top)
Ctrl-b j    # Move to bottom pane  
Ctrl-b %    # Split vertically (bottom)

# Navigate and set up each pane:
# Pane 0 (top-left): nvim
# Pane 1 (top-right): claude
# Pane 2 (bottom-left): git status / lazygit
# Pane 3 (bottom-right): bin/dev
```

### Using dev-session Script
```bash
# Add alias to ~/.bashrc (already configured)
alias dev="/Users/christine/Documents/Repos/dev_scripts/dev-session"

# Usage: cd to your Rails project, then run:
dev

# Or with custom session name:
dev my-session-name

# Or with specific directory:
dev session-name /path/to/project
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
- `Ctrl-b h/j/k/l` - Navigate panes (if configured)
- `Ctrl-b ←/↓/↑/→` - Navigate panes (default)
- `Ctrl-b z` - Toggle pane fullscreen
- `Ctrl-b c` - New window
- `Ctrl-b 1,2,3,4` - Switch windows

### Session Management
```bash
# List sessions
tmux list-sessions

# Attach to session
tmux attach-session -t session-name

# Detach (keeps running)
Ctrl-b d

# Kill session
tmux kill-session -t session-name
```

## ~/.tmux.conf Settings

```bash
# Better pane navigation (Vim-like)
bind h select-pane -L
bind j select-pane -D
bind k select-pane -U
bind l select-pane -R

# Quick pane splitting
bind | split-window -h -c '#{pane_current_path}'
bind - split-window -v -c '#{pane_current_path}'

# Resize panes easily
bind -r H resize-pane -L 5
bind -r J resize-pane -D 5
bind -r K resize-pane -U 5
bind -r L resize-pane -R 5

# Start windows and panes at 1, not 0
set -g base-index 1
setw -g pane-base-index 1

# Enable mouse support
set -g mouse on
```

## Development Flow

### Pane Responsibilities
1. Neovim (Pane 0) - Primary editing
2. Claude Code (Pane 1) - AI assistance without context switching
3. Git/Tests (Pane 2) - Quick commands: `git st`, `rspec`, `git pf`, `lazygit`
4. Rails Server (Pane 3) - Monitor logs with `bin/dev`

### Workflow Pattern
```bash
# 1. Start in Neovim pane (0) - edit code
# 2. Ctrl-b → to Claude pane (1) - ask for help or generate code
# 3. Ctrl-b ↓ to Rails pane (3) - check server response
# 4. Ctrl-b ← to Git pane (2) - run tests: bundle exec rspec, commit changes
# 5. Ctrl-b ↑ back to Neovim - implement fixes and continue
```

## Claude Code Integration

### Useful Commands
- "Show me where X is implemented" - Get file:line references
- "Find all places that use Y" - Search and analyze codebase
- "Write RSpec tests for this feature" - Generate tests
- "Following this app's patterns, implement..." - Get convention-aware code

### Working with Context
Claude remembers git state, recent edits, and preferences. Reference earlier work ("that test we just wrote") and share conventions early: commit styles, code patterns, git aliases.

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
Sessions survive sleep/wake cycles. Detach with `Ctrl-b d` and reattach anytime.

### Pane Management
- Use `Ctrl-b z` to zoom when reading longer Claude responses
- Resize panes based on current task
- Create multiple windows for different work (feature vs debugging)