# Christine's Dotfiles

> *Config files of a Ruby developer who refuses to leave the terminal and is teaching AI to pair program*

Primarily for me (hi future Christine!), but if you're a Ruby dev who lives in the terminal or you're curious about AI-assisted workflows, steal what works.

## What's Inside

### Shell & Terminal
- `.bashrc` & `.bash_profile` - Bash with mise for version management
- `.zshrc` - Minimal zsh config for when I reach for it
- **Starship prompt** with three themes: Tokyo Night, Catppuccin Mocha, Gruvbox

### Neovim
- `.config/nvim/init.lua` - Lua config with vim-plug (it works and I'm stubborn)
- Gruvbox theme, Rails plugins, FZF integration

### Tmux
- `.config/tmux/` - Modular config with three coordinated themes
- Vim-style copy/paste that actually works with macOS
- Pane borders with status indicators, theme switching via `switch-theme.sh`

### AI Workflow
- `dev-scripts/dev-session` - Sets up a 2-pane tmux layout: shell + Claude
- `.claude/` - Claude Code preferences (code style, git workflow, PR conventions)

### Git
- `.gitconfig` - Aliases (`git pf`, `git can`, `git up`), worktree helpers (`git wclean`, `git wlist`), GPG signing

## The Layout

```
┌─────────────────────────┬─────────────────────────┐
│                         │                         │
│   Shell                 │   Claude Code           │
│   (commands, server)    │   (AI pair programmer)  │
│                         │                         │
└─────────────────────────┴─────────────────────────┘
```

Claude handles editing, git, tests, and codebase exploration directly. The shell is for servers, migrations, and anything needing direct control.

## Quick Start

```bash
# Full setup
git clone <your-repo-url> ~/Documents/Repos/dotfiles
./install-themes.sh
exec $SHELL

# Or symlink what you want
ln -sf ~/Documents/Repos/dotfiles/.config/tmux ~/.config/tmux
ln -sf ~/Documents/Repos/dotfiles/.config/nvim ~/.config/nvim
ln -sf ~/Documents/Repos/dotfiles/.config/starship.toml ~/.config/starship.toml
ln -sf ~/Documents/Repos/dotfiles/.gitconfig ~/.gitconfig
ln -sf ~/Documents/Repos/dotfiles/dev-scripts/dev-session ~/bin/dev-session
```

## Recent Changes

- **2-pane layout** (Feb 2026) - Shell + Claude replaces the old 4-pane setup
- **mise migration** - Replaced asdf and nodenv
- **Worktree aliases** - `git wclean`, `git wlist`, `git wt-status`
- **Theme system** (Aug 2025) - Three coordinated themes across tmux and Starship

---

Opinionated and personal. Your mileage may vary. If you spot something wrong, let me know -- Rails devs gotta stick together.
