# Tmux Configuration Migration Notes

## Important: Remove Old Configuration

When installing these new tmux themes, you **must** disable or remove the old `~/.tmux.conf` file to prevent theme conflicts.

### The Problem
The old `~/.tmux.conf` contains the `egel/tmux-gruvbox` plugin which overrides the new Tokyo Night/Catppuccin themes, causing:
- Gruvbox colors to appear in the status bar instead of the chosen theme
- Inconsistent styling between panes and status bar
- Plugin conflicts

### The Solution
```bash
# Backup and disable the old config
mv ~/.tmux.conf ~/.tmux.conf.old-backup

# The new configuration uses the modular approach:
# ~/.config/tmux/.brandnew_setup_tmux.conf (main file)
# ~/.config/tmux/config/ (modular components)
```

### Key Differences

**Old Configuration (`.tmux.conf`):**
- Single monolithic file
- Gruvbox plugin with hardcoded colors
- Basic pane styling
- Plugin-dependent theming

**New Configuration (`.config/tmux/`):**
- Modular structure for easy maintenance
- Pure CSS-style theming without plugin dependencies
- Enhanced pane visibility with strong contrast
- Theme switching system
- Fixed copy/paste functionality

### Migration Checklist

When setting up on a new machine:

1. ✅ **Backup old config:** `mv ~/.tmux.conf ~/.tmux.conf.backup`
2. ✅ **Install new config:** Use `install-themes.sh` from dotfiles
3. ✅ **Remove gruvbox plugin:** Ensure no `egel/tmux-gruvbox` references
4. ✅ **Test themes:** Use `~/.config/tmux/switch-theme.sh`
5. ✅ **Verify copy/paste:** Test vim-style copy with `Ctrl-t [` then `v`, `y`

### Status Bar Colors

**Tokyo Night:**
- Background: `#0f1115` (very dark)
- Text: `#c0caf5` (soft blue-white)
- Accents: Purple (`#bb9af7`) and blue (`#7aa2f7`)

**Catppuccin:**
- Background: `#181825` (mantle)
- Text: `#cdd6f4` (text)
- Accents: Lavender (`#b4befe`) and mauve (`#cba6f7`)

### Troubleshooting

If you still see Gruvbox colors:
1. Check for `~/.tmux.conf` file - rename it if it exists
2. Kill tmux server: `tmux kill-server`
3. Restart tmux with: `tmux new-session`
4. Source config: `tmux source-file ~/.config/tmux/.brandnew_setup_tmux.conf`