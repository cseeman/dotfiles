# Christine's Dotfiles

> *Config files of a Ruby developer who refuses to leave the terminal and is teaching AI to pair program*

Primarily for me (hi future Christine!), but if you're a Ruby dev who lives in the terminal or you're curious about AI-assisted workflows, steal what works.

## What's Inside

### Shell & Terminal
- `.bash_profile` & `.bashrc` - Homebrew bash 5 with mise for version management
- `.zprofile` & `.zshrc` - Minimal zsh, kept in step with bash for when I reach for it
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

Switching a theme also sets the Starship palette, the Alacritty theme, glow's
style, and Neovim's background to match. Details in `.config/tmux/THEMES.md`.

### Alacritty
- `alacritty/alacritty.toml` - Window, shell, and two pointer imports: theme and font
- `alacritty/fonts/` - One file per font; `switch-font.sh <name>` picks one

### Zed
- `.config/zed/settings.json` - Vim mode, panels docked left, theme follows the system

### AI Workflow
- `bin/dev-session` - One 2-pane tmux session per worktree: shell + Claude (docs in `bin/README.md`)
- `bin/git-recent` - Recently active branches, sized to the terminal
- `.claude/` - Claude Code preferences (code style, git workflow, PR conventions)

### Git
- `.gitconfig` - Aliases (`git pf`, `git can`, `git up`), `git wlist`, GPG signing
- `bin/git-wclean` - Removes a clean worktree and its merged branch
- Stacked-branch defaults: `rebase.updateRefs`, `autoSquash`, `autoStash`, `rerere`, `push.autoSetupRemote`

`CHEATSHEET.md` lists the keys and commands worth remembering; `cheat` opens it
in glow from any shell.

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
git clone git@github.com:cseeman/dotfiles.git ~/Documents/Repos/dotfiles
cd ~/Documents/Repos/dotfiles
./install.sh --dry-run   # see what would change
./install.sh
```

The installer, in order:

1. Symlinks every config into `$HOME`, moving anything it replaces to `~/.dotfiles-backup/<timestamp>/`.
2. Runs `brew bundle` from the Brewfile (skip with `--no-brew`). On a fresh
   Mac, `--apps` also installs the desktop and App Store apps in `Brewfile.apps`.
3. Clones tpm and installs the tmux plugins.
4. Clones the alacritty-theme collection.
5. Sets the default tmux theme (equinox-dawn) and Alacritty font (Maple) if none is active.
6. Fetches vim-plug and installs the Neovim plugins.
7. Installs the launch agent behind `pr-rereview-notify`.
8. Turns on this repo's pre-push check.

Re-running is safe; links already in place are skipped.

Machine-specific settings stay out of the repo: `~/.bashrc.local`,
`~/.zshrc.local`, and `~/.gitconfig.local` are sourced or included when
present. Set `user.email` in `~/.gitconfig.local`. `~/.pr-tools.local` holds the repos the PR scripts query, see
`bin/README.md`.

Private GitHub gems need a classic PAT with only `read:packages`, stored once:
`bundle config set --global rubygems.pkg.github.com <login>:<pat>`.

`hooks/pre-push` blocks pushes containing secrets or anything matching the
regexes in the untracked `~/.dotfiles-private-patterns`, one per line.

`make check` lints the shell scripts, sources every tmux config into a scratch
server, and starts Neovim headless. Run it before committing.

---

Opinionated and personal. Your mileage may vary. If you spot something wrong, let me know, Rails devs gotta stick together.
