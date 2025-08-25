#!/bin/bash

# Theme Installation Script for Christine's Dotfiles
# Installs modern tmux and Starship configurations

set -e

echo "🎨 Installing Christine's Modern Themes..."
echo ""

DOTFILES_DIR="$HOME/Documents/Repos/dotfiles"
CONFIG_DIR="$HOME/.config"

# Function to backup existing config
backup_if_exists() {
    local file="$1"
    if [[ -f "$file" || -d "$file" ]]; then
        echo "  📦 Backing up existing $file"
        mv "$file" "${file}.backup.$(date +%Y%m%d_%H%M%S)"
    fi
}

# Function to create symlinks
create_symlink() {
    local source="$1"
    local target="$2"
    echo "  🔗 Linking $target"
    ln -sf "$source" "$target"
}

echo "1. Installing Tmux Configuration..."
backup_if_exists "$CONFIG_DIR/tmux"
mkdir -p "$CONFIG_DIR"
create_symlink "$DOTFILES_DIR/.config/tmux" "$CONFIG_DIR/tmux"

echo ""
echo "2. Installing Starship Configuration..."
backup_if_exists "$CONFIG_DIR/starship.toml"
create_symlink "$DOTFILES_DIR/.config/starship.toml" "$CONFIG_DIR/starship.toml"
create_symlink "$DOTFILES_DIR/.config/starship-catppuccin.toml" "$CONFIG_DIR/starship-catppuccin.toml"
create_symlink "$DOTFILES_DIR/.config/starship-gruvbox-backup.toml" "$CONFIG_DIR/starship-gruvbox-backup.toml"

echo ""
echo "3. Installing Theme Switchers..."
create_symlink "$DOTFILES_DIR/.config/switch-starship-theme.sh" "$CONFIG_DIR/switch-starship-theme.sh"
create_symlink "$DOTFILES_DIR/.config/switch-theme.sh" "$CONFIG_DIR/switch-theme.sh"

echo ""
echo "4. Setting up permissions..."
chmod +x "$CONFIG_DIR/tmux/switch-theme.sh"
chmod +x "$CONFIG_DIR/switch-starship-theme.sh"
chmod +x "$CONFIG_DIR/switch-theme.sh"

echo ""
echo "✨ Installation Complete!"
echo ""
echo "🎨 Available Themes:"
echo "  • tokyo      - Tokyo Night (blue/purple, currently active)"
echo "  • catppuccin - Catppuccin Mocha (soft pastels)"
echo "  • gruvbox    - Your original Gruvbox theme"
echo ""
echo "🔧 Usage:"
echo "  # Switch both tmux and Starship themes together"
echo "  ~/.config/switch-theme.sh catppuccin"
echo ""
echo "  # Or switch individually"
echo "  ~/.config/tmux/switch-theme.sh tokyo"
echo "  ~/.config/switch-starship-theme.sh tokyo"
echo ""
echo "💡 Notes:"
echo "  • Tmux: Changes apply immediately (Ctrl-t r to reload)"
echo "  • Starship: Restart your shell or run 'exec \$SHELL'"
echo "  • Your old configs are backed up with timestamp"
echo ""
echo "📚 Documentation:"
echo "  • Tmux: ~/.config/tmux/copy-paste-reference.md"
echo "  • Starship: ~/.config/starship-themes-guide.md"