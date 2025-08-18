# Development Workflow with Tmux + Claude Code

## Optimal 4-Pane Tmux Layout

```
┌─────────────────────────┬─────────────────────────┐
│ Pane 1: Neovim         │ Pane 2: Rails server    │
│ (editing code)          │ (watching logs)         │
├─────────────────────────┼─────────────────────────┤
│ Pane 3: Git/Tests      │ Pane 4: Claude Code     │
│ (git st, rspec)        │ (complex tasks, help)   │
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
# Pane 1 (top-left): nvim
# Pane 2 (top-right): rails s -p 3001
# Pane 3 (bottom-left): git status
# Pane 4 (bottom-right): claude
```

### Using dev-session Script
```bash
# Make executable if needed
chmod +x ~/Documents/Repos/dev_scripts/dev-session

# Run the script
~/Documents/Repos/dev_scripts/dev-session
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

## Recommended ~/.tmux.conf Settings

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

## Development Flow Benefits

### Pane Responsibilities
1. **Neovim (Pane 1)** - Primary editing, stay in flow state
2. **Rails Server (Pane 2)** - Monitor logs, see real-time feedback
3. **Git/Tests (Pane 3)** - Quick commands: `git st`, `rspec`, `git pf`
4. **Claude Code (Pane 4)** - AI assistance without context switching

### Workflow Pattern
```bash
# 1. Start in Neovim pane - edit code
# 2. Ctrl-b → to Rails pane - check server response
# 3. Ctrl-b ↓ ← to Git pane - run tests: bundle exec rspec
# 4. Ctrl-b → to Claude pane - ask for help with failures
# 5. Ctrl-b ← ↑ back to Neovim - implement fixes
```

## Claude Code Integration Tips

### Effective Commands
- **"Show me where X is implemented"** - Get file:line references
- **"Find all places that use Y"** - Codebase search and analysis
- **"Write RSpec tests for this feature"** - Test generation
- **"Following this app's patterns, implement..."** - Convention-aware code

### Context Maintenance
- Claude remembers your git state, recent edits, and preferences
- Reference previous work: "that test we just wrote"
- Share preferences early: commit styles, code patterns, git aliases

## Git Aliases Integration

Your preferred aliases work seamlessly:
```bash
git st      # status
git pf      # push --force-with-lease
git can     # commit --amend --no-edit
git up      # pull --rebase --autostash
```

## Pro Tips

### Session Persistence
- Sessions survive computer sleep/wake
- Detach with `Ctrl-b d`, reattach anytime
- Perfect for multi-day feature development

### Pane Management
- Use `Ctrl-b z` to focus on complex Claude explanations
- Resize panes based on current task (more space for tests vs editing)
- Create multiple windows for different aspects (feature vs debugging)

### Integration Benefits
- No context switching between tools
- Maintain flow state while getting AI assistance  
- Visual feedback from all development aspects simultaneously
- Quick iteration cycles: edit → test → commit → ask Claude

---

*This workflow optimizes for developer flow state while maximizing the benefits of AI-assisted development.*