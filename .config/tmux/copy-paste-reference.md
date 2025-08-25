# Tmux Copy/Paste Reference

## How to Copy Text in Tmux

### Method 1: Keyboard Navigation
1. **Enter Copy Mode:** `Ctrl-t [` (your prefix is Ctrl-t)
2. **Navigate:** Use vim keys (`h`, `j`, `k`, `l`) or arrow keys
3. **Start Selection:** Press `v` (just like vim visual mode)
4. **Select Text:** Navigate to extend selection
5. **Copy Options:**
   - **Copy and Stay:** Press `y` (stays in copy mode for more copying)
   - **Copy and Exit:** Press `Enter` (exits copy mode)
6. **Paste:** `Ctrl-t P` (capital P)

### Method 2: Mouse Selection
1. **Select with Mouse:** Click and drag to select text
2. **Auto-Copy:** Text is automatically copied to clipboard when you release
3. **Paste:** `Ctrl-t P` or paste anywhere with `Cmd-V`

### Method 3: Rectangle Selection
1. **Enter Copy Mode:** `Ctrl-t [`
2. **Start Rectangle Selection:** `Ctrl-v`
3. **Select Area:** Navigate to create rectangle
4. **Copy:** Press `y` or `Enter`

## Key Bindings Summary

- `Ctrl-t [` - Enter copy mode
- `v` - Start visual selection (in copy mode)
- `Ctrl-v` - Rectangle/block selection (in copy mode)
- `y` - Copy selection and stay in copy mode
- `Enter` - Copy selection and exit copy mode
- `Ctrl-t P` - Paste from tmux buffer
- `Esc` - Exit copy mode without copying

## Troubleshooting

If copying isn't working:
1. Make sure you're in a tmux session
2. Try reloading config: `Ctrl-t r` (or manually: `tmux source-file ~/.config/tmux/.brandnew_setup_tmux.conf`)
3. Check if pbcopy works: `echo "test" | pbcopy` then `pbpaste`

## Pane Visibility Features

- **Active Pane:** Brighter background and bold blue border
- **Inactive Panes:** Dimmed with subtle gray borders
- **Pane Indicators:** `●` for active pane, `○` for inactive
- **Pane Numbers:** Press `Ctrl-t q` to display pane numbers (2 seconds)

## Advanced Tips

- **Search in Copy Mode:** `/` (forward) or `?` (backward)
- **Jump to Next/Prev Word:** `w`/`b` (like vim)
- **Jump to Line Start/End:** `0`/`$` (like vim)
- **Page Up/Down:** `Ctrl-b`/`Ctrl-f` (like vim)