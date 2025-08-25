#!/bin/bash

# Universal Theme Switcher
# Switches both tmux and Starship themes together
# Usage: ./switch-theme.sh [theme-name]

SCRIPT_DIR="$HOME/.config"

# Function to switch both themes
switch_unified_theme() {
    local theme_name="$1"
    
    case "$theme_name" in
        tokyo|tokyo-night)
            echo "🌃 Switching to Tokyo Night theme..."
            "$SCRIPT_DIR/tmux/switch-theme.sh" tokyo 2>/dev/null || echo "   tmux: theme not found"
            "$SCRIPT_DIR/switch-starship-theme.sh" tokyo || echo "   starship: theme not found"
            ;;
        catppuccin|mocha)
            echo "🌙 Switching to Catppuccin Mocha theme..."
            "$SCRIPT_DIR/tmux/switch-theme.sh" catppuccin 2>/dev/null || echo "   tmux: theme not found"
            "$SCRIPT_DIR/switch-starship-theme.sh" catppuccin || echo "   starship: theme not found"
            ;;
        gruvbox)
            echo "🌰 Switching to Gruvbox theme..."
            "$SCRIPT_DIR/tmux/switch-theme.sh" original 2>/dev/null || echo "   tmux: theme not found"
            "$SCRIPT_DIR/switch-starship-theme.sh" gruvbox || echo "   starship: theme not found"
            ;;
        *)
            echo "Available themes:"
            echo "  tokyo      - Tokyo Night (blue/purple)"
            echo "  catppuccin - Catppuccin Mocha (soft pastels)"  
            echo "  gruvbox    - Gruvbox (warm earth tones)"
            echo ""
            echo "Usage: $0 <theme-name>"
            echo "Example: $0 tokyo"
            return 1
            ;;
    esac
    
    echo ""
    echo "✨ Theme switch complete!"
    echo "💡 For Starship: restart your shell or run 'exec \$SHELL'"
    echo "💡 For tmux: changes apply immediately to current sessions"
}

switch_unified_theme "$1"