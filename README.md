# Christine's Dotfiles

> *Config files of a Ruby developer who refuses to leave the terminal and is teaching AI to pair program*

Primarily for me (hi future Christine!), but if you're a Ruby dev who lives in the terminal or you're curious about AI-assisted workflows, steal what works.

## What's Inside

### Shell & Terminal
- `.bashrc` & `.bash_profile` - Bash with mise for version management
- `.zshrc` - Minimal zsh config for when I reach for it
- **Starship prompt** with a palette generated for every tmux theme

### Neovim
- `.config/nvim/init.lua` - Lua config with vim-plug (it works and I'm stubborn)
- Gruvbox theme, Rails plugins, FZF integration

### Tmux
- `.config/tmux/` - Modular config with eleven themes and a switcher (see `THEMES.md`)
- Vim-style copy/paste that actually works with macOS
- Pane borders with status indicators

**Themes** (switch with `switch-theme.sh <name>` or prefix + T):
| Name | Mode | Notes |
|------|------|-------|
| `tokyo` | dark | Blue/purple, the original |
| `catppuccin` | dark | Soft pastels |
| `everforest` | dark | Nature-inspired, best readability for diffs |
| `solstice` | dark | Tropical ocean at dusk |
| `equinox` | dark | Woodsmoke and late harvest |
| `original` | dark | The first saved theme, a Catppuccin variant |
| `latte` | light | Catppuccin light variant |
| `rosepine-dawn` | light | Warm cream, high contrast for reading AI output |
| `gruvbox-light` | light | Warm neutral, highest contrast for terminal tools |
| `solstice-dawn` | light | Sunrise on the beach |
| `equinox-dawn` | light | Light through turning leaves |

Switching a theme also sets the Starship palette, glow's style, and Neovim's
background to match. Details in `.config/tmux/THEMES.md`.

### Alacritty
- `alacritty/alacritty.toml` - Window, shell, and theme import
- `alacritty/fonts/` - One file per font; `switch-font.sh <name>` picks one

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
git clone <your-repo-url> ~/Documents/Repos/dotfiles
cd ~/Documents/Repos/dotfiles
./install.sh --dry-run   # see what would change
./install.sh             # symlink configs, brew bundle, tmux + nvim plugins
```

Anything the installer replaces is moved to `~/.dotfiles-backup/<timestamp>/`.
Pass `--no-brew` to skip the Brewfile. Re-running is safe; links already in
place are skipped.

`make check` lints the shell scripts, sources every tmux config into a scratch
server, and starts Neovim headless. Run it before committing.

---

Opinionated and personal. Your mileage may vary. If you spot something wrong, let me know -- Rails devs gotta stick together.
