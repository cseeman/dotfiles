# Starship Theme Guide

Your Starship prompt now matches your tmux themes perfectly! Here's everything you need to know.

## Available Themes

### 🌃 Tokyo Night (Default)
- **Colors:** Deep blues, purples, and vibrant accents
- **Style:** Modern, clean, highly readable
- **Perfect for:** Development work, long coding sessions
- **Matches:** tmux Tokyo Night theme

### 🌙 Catppuccin Mocha  
- **Colors:** Soft pastels with lavender highlights
- **Style:** Elegant, gentle on the eyes
- **Perfect for:** Extended terminal usage, softer aesthetic preference
- **Matches:** tmux Catppuccin theme

### 🌰 Gruvbox (Your Original)
- **Colors:** Warm earth tones, brown/orange palette
- **Style:** Retro, warm, comfortable
- **Perfect for:** Those who prefer warmer color schemes
- **Matches:** Your original prompt style

## Theme Switching

### Individual Theme Switchers
```bash
# Starship only
~/.config/switch-starship-theme.sh tokyo
~/.config/switch-starship-theme.sh catppuccin
~/.config/switch-starship-theme.sh gruvbox

# Tmux only  
~/.config/tmux/switch-theme.sh tokyo
~/.config/tmux/switch-theme.sh catppuccin
```

### Unified Theme Switcher (Recommended)
```bash
# Switch both tmux and Starship together
~/.config/switch-theme.sh tokyo
~/.config/switch-theme.sh catppuccin
~/.config/switch-theme.sh gruvbox
```

## Prompt Features

### Smart Information Display
- **Username/Hostname:** Only shown when SSH or root
- **Directory:** Smart truncation with meaningful icons (shows up to 5 levels)
- **Git Info:** Branch (up to 35 characters), status, and change metrics
- **Languages:** Auto-detected with version numbers
- **Performance:** Command duration for slow commands
- **Battery:** Level indicators on laptops

### Git Status Icons
- `? ` - Untracked files
- `! ` - Modified files  
- `+ ` - Staged files
- `✘ ` - Deleted files
- `» ` - Renamed files
- `󰏗 ` - Stashed changes
- `⇡3 ` - Ahead by 3 commits
- `⇣2 ` - Behind by 2 commits

### Language Detection
- `󰎙 ` Node.js (when package.json present)
- `󰌠 ` Python (when .py files or venv active)
- `󰴭 ` Ruby (when Gemfile or .rb files present)
- `󱘗 ` Rust (when Cargo.toml present)
- `󰟓 ` Go (when go.mod present)
- `󰬷 ` Java (when pom.xml or build.gradle present)

### Vim Mode Support
- `❯` - Normal mode (green=success, red=error)
- `❮` - Vim command mode (changes color by mode)

## Customization

### Enable Additional Features
Edit `~/.config/starship.toml`:

```toml
# Show time in prompt
[time]
disabled = false

# Show git server icons
[custom.git_server] 
disabled = false

# Show shell type
[shell]
disabled = false
```

### Adjust Colors
Each theme has its own palette. You can modify colors by editing the `[palettes.theme_name]` section.

### Performance Tips
- Git metrics can be disabled if git repos are large
- Command duration threshold can be adjusted
- Username display can be forced always on

## Troubleshooting

### Theme Not Applying
```bash
# Restart shell
exec $SHELL

# Or source your shell config
source ~/.zshrc  # or ~/.bashrc
```

### Missing Icons
Make sure you have a Nerd Font installed:
- Download from https://nerdfonts.com
- Install MesloLGS NF or Fira Code Nerd Font
- Set as terminal font

### Slow Prompt
Disable heavy features:
```toml
[git_metrics]
disabled = true

[kubernetes]
disabled = true
```

## File Locations

- **Active Config:** `~/.config/starship.toml`
- **Tokyo Theme:** `~/.config/starship.toml` (when tokyo active)
- **Catppuccin Theme:** `~/.config/starship-catppuccin.toml`
- **Gruvbox Backup:** `~/.config/starship-gruvbox-backup.toml`
- **Theme Switchers:** `~/.config/switch-*-theme.sh`