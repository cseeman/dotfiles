#!/bin/bash

# Alacritty Font Switcher
# Usage: ./switch-font.sh [font-name]

ALACRITTY_CONFIG="$HOME/.config/alacritty/alacritty.toml"
BACKUP_CONFIG="$HOME/.config/alacritty/alacritty.toml.backup"

# Create backup if it doesn't exist
if [[ ! -f "$BACKUP_CONFIG" ]]; then
    cp "$ALACRITTY_CONFIG" "$BACKUP_CONFIG"
fi

switch_font() {
    local font_name="$1"
    
    case "$font_name" in
        jetbrains)
            cat > "$ALACRITTY_CONFIG" << 'EOF'
[general]
import = [
    "~/.config/alacritty/themes/themes/carbonfox.toml"
]

[env]
TERM = "xterm-256color"

[window]
startup_mode = "Fullscreen"
decorations = "None"
opacity = 0.7
padding = { x = 16 , y = 16 }

[font]
normal = { family = "JetBrainsMono Nerd Font", style = "Regular" }
bold = { family = "JetBrainsMono Nerd Font", style = "Bold" }
italic = { family = "JetBrainsMono Nerd Font", style = "Italic" }
bold_italic = { family = "JetBrainsMono Nerd Font", style = "Bold Italic" }

size = 14

[font.offset]
x = 0
y = 1

[terminal.shell]
program = "/bin/bash"
args = ["-l"]
EOF
            echo "✅ Switched to JetBrains Mono (modern, with ligatures)"
            ;;
            
        monaspace|neon)
            cat > "$ALACRITTY_CONFIG" << 'EOF'
[general]
import = [
    "~/.config/alacritty/themes/themes/carbonfox.toml"
]

[env]
TERM = "xterm-256color"

[window]
startup_mode = "Fullscreen"
decorations = "None"
opacity = 0.7
padding = { x = 16 , y = 16 }

[font]
normal = { family = "MonaspaceNeon NFM", style = "Regular" }
bold = { family = "MonaspaceNeon NFM", style = "Bold" }
italic = { family = "MonaspaceRadon NFM", style = "Italic" }
bold_italic = { family = "MonaspaceNeon NFM", style = "Bold Italic" }

size = 14

[font.offset]
x = 0
y = 0

[terminal.shell]
program = "/bin/bash"
args = ["-l"]
EOF
            echo "✅ Switched to Monaspace Neon (GitHub's new font with texture healing)"
            ;;
            
        argon)
            cat > "$ALACRITTY_CONFIG" << 'EOF'
[general]
import = [
    "~/.config/alacritty/themes/themes/carbonfox.toml"
]

[env]
TERM = "xterm-256color"

[window]
startup_mode = "Fullscreen"
decorations = "None"
opacity = 0.7
padding = { x = 16 , y = 16 }

[font]
normal = { family = "MonaspaceArgon NFM", style = "Regular" }
bold = { family = "MonaspaceArgon NFM", style = "Bold" }
italic = { family = "MonaspaceArgon NFM", style = "Italic" }
bold_italic = { family = "MonaspaceArgon NFM", style = "Bold Italic" }

size = 14

[font.offset]
x = 0
y = 0

[terminal.shell]
program = "/bin/bash"
args = ["-l"]
EOF
            echo "✅ Switched to Monaspace Argon (clean, minimal variant)"
            ;;
            
        meslo|classic)
            cat > "$ALACRITTY_CONFIG" << 'EOF'
[general]
import = [
    "~/.config/alacritty/themes/themes/carbonfox.toml"
]

[env]
TERM = "xterm-256color"

[window]
startup_mode = "Fullscreen"
decorations = "None"
opacity = 0.7
padding = { x = 16 , y = 16 }

[font]
normal.family = "MesloLGS Nerd Font Mono"

size = 16

[terminal.shell]
program = "/bin/bash"
args = ["-l"]
EOF
            echo "✅ Switched to MesloLGS (classic font)"
            ;;
            
        *)
            echo "Available fonts:"
            echo "  jetbrains - JetBrains Mono (recommended, with ligatures)"
            echo "  monaspace - Monaspace Neon (GitHub's font with texture healing)"
            echo "  argon     - Monaspace Argon (clean minimal variant)"
            echo "  meslo     - MesloLGS (your classic font)"
            echo ""
            echo "Usage: $0 <font-name>"
            echo "Example: $0 jetbrains"
            return 1
            ;;
    esac
    
    echo ""
    echo "💡 Restart Alacritty to see the new font"
    echo "💡 Test ligatures: -> => != === ++ -- >= <="
}

# Main
if [[ $# -eq 0 ]]; then
    echo "Current font configuration:"
    grep -E "family|size" "$ALACRITTY_CONFIG" | head -5
    echo ""
    switch_font
else
    switch_font "$1"
fi