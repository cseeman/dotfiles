#!/bin/bash

# Tmux Theme Switcher
# Usage: ./switch-theme.sh [theme-name]

TMUX_CONFIG_DIR="$HOME/.config/tmux"
THEME_DIR="$TMUX_CONFIG_DIR/config"
CURRENT_THEME_LINK="$THEME_DIR/theme.conf"

# Theme registry: name|file|mode
THEMES=(
    "tokyo|theme-tokyo.conf|dark"
    "catppuccin|theme-catppuccin.conf|dark"
    "everforest|theme-everforest.conf|dark"
    "latte|theme-catppuccin-latte.conf|light"
    "rosepine-dawn|theme-rosepine-dawn.conf|light"
    "gruvbox-light|theme-gruvbox-light.conf|light"
    "original|theme-original.conf|dark"
)

# Function to get theme file
get_theme_file() {
    for entry in "${THEMES[@]}"; do
        IFS='|' read -r name file mode <<< "$entry"
        if [[ "$name" == "$1" ]]; then
            echo "$file"
            return
        fi
    done
    echo ""
}

# Function to list available themes
list_themes() {
    echo "Available themes:"
    for entry in "${THEMES[@]}"; do
        IFS='|' read -r name file mode <<< "$entry"
        if [[ -f "$THEME_DIR/$file" ]]; then
            if [[ "$CURRENT_THEME_LINK" -ef "$THEME_DIR/$file" ]]; then
                echo "  * $name ($mode) (current)"
            else
                echo "    $name ($mode)"
            fi
        fi
    done
}

# Function to switch theme
switch_theme() {
    local theme_name="$1"
    local theme_file=$(get_theme_file "$theme_name")
    
    if [[ -z "$theme_file" ]]; then
        echo "Error: Unknown theme '$theme_name'"
        echo ""
        list_themes
        return 1
    fi
    
    theme_file="$THEME_DIR/$theme_file"
    
    if [[ ! -f "$theme_file" ]]; then
        echo "Error: Theme file '$theme_file' not found"
        return 1
    fi
    
    # Backup current theme
    if [[ -f "$CURRENT_THEME_LINK" && ! -L "$CURRENT_THEME_LINK" ]]; then
        mv "$CURRENT_THEME_LINK" "$THEME_DIR/theme-original.conf"
        echo "Backed up original theme to theme-original.conf"
    fi
    
    # Create or update symlink
    ln -sf "$theme_file" "$CURRENT_THEME_LINK"
    
    # Reload tmux config
    tmux source-file "$TMUX_CONFIG_DIR/tmux.conf" 2>/dev/null
    
    echo "✨ Switched to '$theme_name' theme"
    echo "   Theme will be applied to all tmux sessions"
    
    # Show a tmux message if in a tmux session
    if [[ -n "$TMUX" ]]; then
        tmux display-message "Theme switched to: $theme_name"
    fi
}

# Main script
main() {
    # First, save the current theme.conf as tokyo theme if it doesn't exist
    if [[ ! -f "$THEME_DIR/theme-tokyo.conf" && -f "$CURRENT_THEME_LINK" ]]; then
        cp "$CURRENT_THEME_LINK" "$THEME_DIR/theme-tokyo.conf"
        echo "Saved current theme as 'tokyo'"
    fi
    
    if [[ $# -eq 0 ]]; then
        list_themes
        echo ""
        echo "Usage: $0 <theme-name>"
        echo "Example: $0 catppuccin"
    else
        switch_theme "$1"
    fi
}

main "$@"