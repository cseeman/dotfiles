#!/bin/bash

# Starship Theme Switcher
# Usage: ./switch-starship-theme.sh [theme-name]

STARSHIP_CONFIG_DIR="$HOME/.config"
CURRENT_CONFIG="$STARSHIP_CONFIG_DIR/starship.toml"

# Function to get theme file
get_theme_file() {
    case "$1" in
        tokyo) echo "starship.toml" ;;
        catppuccin) echo "starship-catppuccin.toml" ;;
        latte) echo "starship-catppuccin-latte.toml" ;;
        gruvbox) echo "starship-gruvbox-backup.toml" ;;
        *) echo "" ;;
    esac
}

# Function to list available themes
list_themes() {
    echo "Available Starship themes:"
    for name in tokyo catppuccin latte gruvbox; do
        theme_file=$(get_theme_file "$name")
        if [[ -f "$STARSHIP_CONFIG_DIR/$theme_file" ]]; then
            # Simple check - see if this theme is currently active
            if [[ "$name" == "tokyo" && -f "$CURRENT_CONFIG" ]]; then
                if grep -q "palette = 'tokyo_night'" "$CURRENT_CONFIG" 2>/dev/null; then
                    echo "  * $name (current)"
                else
                    echo "    $name"
                fi
            elif [[ "$name" == "catppuccin" ]]; then
                if grep -q "palette = 'catppuccin_mocha'" "$CURRENT_CONFIG" 2>/dev/null; then
                    echo "  * $name (current)"
                else
                    echo "    $name"
                fi
            elif [[ "$name" == "latte" ]]; then
                if grep -q "palette = 'catppuccin_latte'" "$CURRENT_CONFIG" 2>/dev/null; then
                    echo "  * $name (current)"
                else
                    echo "    $name"
                fi
            elif [[ "$name" == "gruvbox" ]]; then
                if grep -q "palette = 'gruvbox_dark'" "$CURRENT_CONFIG" 2>/dev/null; then
                    echo "  * $name (current)"
                else
                    echo "    $name"
                fi
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
    
    local source_file="$STARSHIP_CONFIG_DIR/$theme_file"
    
    if [[ ! -f "$source_file" ]]; then
        echo "Error: Theme file '$source_file' not found"
        return 1
    fi
    
    # Copy the theme file to the active config
    cp "$source_file" "$CURRENT_CONFIG"
    
    echo "✨ Switched to '$theme_name' Starship theme"
    echo "   Theme will be applied to new shell sessions"
    echo ""
    echo "💡 Start a new shell or run: source ~/.zshrc (or ~/.bashrc)"
}

# Main script
main() {
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