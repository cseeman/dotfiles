# Christine's Dotfiles 🚀

> *The ever-evolving config files of a Ruby developer who attempts to not leave the editor and is teaching AI to be a better pair programmer*

Hey there! Welcome to my dotfiles. These are the configuration files that make my development environment feel like home. As a Ruby (Sometimes on Rails) developer who's spent way too much time perfecting my setup (and unbreaking it, a lot), I've finally gotten around to properly versioning these configs.

## Who This Is For

This is primarily for me (hi future Christine! 👋), but if you're:
- A Ruby developer who lives in the terminal
- Someone who is attempting to touch the mouse less
- Curious about integrating AI tools into your workflow without losing your mind
- A tmux enthusiast who likes their pane layouts

...then you might find something useful here!

## The Philosophy

I'm a firm believer that your development environment should get out of your way. These configs represent years of iteration toward that goal, plus my recent adventures in making AI assistants actually useful for real development work (not just fancy autocomplete).

## What's Inside

### 🐚 Shell & Terminal Styling
- `.bashrc` & `.bash_profile` - Because yes, I still use bash sometimes
- `.zshrc` - The minimal zsh config (because sometimes I do reach for zsh)
- **Starship prompt** - Three beautiful themes that match tmux perfectly
  - 🌃 **Tokyo Night** - Modern blue/purple (default)
  - 🌙 **Catppuccin Mocha** - Soft pastels
  - 🌰 **Gruvbox** - Classic warm earth tones

### 💎 Ruby/Rails Tooling
- `.tool-versions` - asdf keeping my Ruby versions in check
- Git aliases that make sense for Rails work (`git pf` is life)

### ✨ The Neovim Setup
- `.config/nvim/init.lua` - My Lua config (finally migrated from Vimscript!)
- Still using vim-plug because it works and I'm stubborn
- Gruvbox theme because my eyes deserve nice things

### 🖥️ Tmux Setup
- **`.config/tmux/`** - Complete modular tmux configuration
  - Three coordinated themes matching Starship
  - Enhanced copy/paste with proper vim bindings
  - Smart pane borders with status indicators
  - Theme switching on-the-fly
- **Fixed reload functionality** (no more "file not found" errors!)

### 🤖 AI Integration Scripts
- `dev-scripts/` - Where the magic happens
  - `dev-session` - Automated tmux setup that puts Claude exactly where I need it
  - A 4-pane layout that actually makes sense for AI-assisted development

### 🎯 Git Configuration
- Aliases that match how my brain works
- GPG signing because security matters
- Commit message conventions that future me will thank current me for

## The Tmux + AI Workflow

After months of experimentation, I've landed on a 4-pane setup that actually works:

```
┌──────────────┬──────────────┐
│   Neovim    │    Claude    │
│  (coding)   │ (questions)  │
├──────────────┼──────────────┤
│   Server    │   lazygit    │
│ (Overmind)  │   (sanity)   │
└──────────────┴──────────────┘
```

Why? Because context switching kills flow. This setup lets me code, ask questions, see logs, and manage Git without ever leaving my happy place.

## Quick Start

### 🚀 Full Setup (Recommended)
```bash
# Clone this repo (if you haven't already)
git clone <your-repo-url> ~/Documents/Repos/dotfiles

# Run the theme installer for the complete modern experience
./install-themes.sh

# Restart your shell to see Starship changes
exec $SHELL
```

### 🔧 Manual Installation (Pick and Choose)
```bash
# Modern tmux + themes (replaces old .tmux.conf)
ln -sf ~/Documents/Repos/dotfiles/.config/tmux ~/.config/tmux

# Starship themes
ln -sf ~/Documents/Repos/dotfiles/.config/starship.toml ~/.config/starship.toml

# Neovim config
ln -sf ~/Documents/Repos/dotfiles/.config/nvim ~/.config/nvim

# Git configuration  
ln -sf ~/Documents/Repos/dotfiles/.gitconfig ~/.gitconfig

# Make the dev-session script available
ln -sf ~/Documents/Repos/dotfiles/dev-scripts/dev-session ~/bin/dev-session
```

## The Evolution

This is a living repository. As I discover new tools, refine my workflow, or finally fix that annoying thing that's been bugging me for months, these configs evolve. Recent additions include:
- **Theme Switching System** (August 2025) - Three coordinated themes across tmux and Starship
- **Enhanced Copy/Paste** - Fixed vim bindings that actually work with macOS
- **Modular tmux Config** - Clean, organized, and easily maintainable
- **Smart Git Branch Display** - No more truncated branch names (up to 35 chars!)
- Claude integration that actually helps rather than hinders
- Overmind setup for managing Rails processes without losing my mind
- lazygit because sometimes GUIs are okay (don't @ me)

## Fair Warning

These configs are highly opinionated and tailored to how my brain works. Your mileage may vary. Feel free to steal what works and ignore what doesn't!

## Contributing

This is my personal setup, but if you spot something obviously wrong or have a clever improvement, I'd love to hear about it! Rails developers gotta stick together.

---

*Last updated: August 2025 - Now with 100% more AI and 50% less GitHub tokens in the bashrc* 😅
