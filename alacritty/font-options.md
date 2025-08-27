# Modern Nerd Font Recommendations

## Top Modern Nerd Fonts for 2024-2025

### 1. **JetBrains Mono Nerd Font** ⭐ HIGHLY RECOMMENDED
- **Why**: Designed specifically for developers with excellent readability
- **Features**: Ligatures, 142 code-specific ligatures, increased height for better readability
- **Install**: `brew install --cask font-jetbrains-mono-nerd-font`
- **Config**: 
```toml
[font]
normal.family = "JetBrainsMono Nerd Font"
size = 14
```

### 2. **Monaspace Nerd Font** (GitHub's new font family) 🚀 NEWEST
- **Why**: Five font variants (Argon, Neon, Xenon, Radon, Krypton) with texture healing
- **Features**: Revolutionary "texture healing" for better character spacing
- **Install**: `brew install --cask font-monaspace-nerd-font`
- **Config**:
```toml
[font]
normal.family = "MonaspaceNeon Nerd Font"  # or MonaspaceArgon, MonaspaceXenon, etc.
size = 14
```

### 3. **Iosevka Nerd Font** 
- **Why**: Highly customizable, narrow for more code on screen
- **Features**: Tons of variants, excellent ligature support
- **Install**: `brew install --cask font-iosevka-nerd-font`
- **Config**:
```toml
[font]
normal.family = "Iosevka Nerd Font"
size = 15
```

### 4. **Fira Code Nerd Font**
- **Why**: Popular, excellent ligature support, very readable
- **Features**: Wide character support, great for symbols
- **Install**: `brew install --cask font-fira-code-nerd-font`
- **Config**:
```toml
[font]
normal.family = "FiraCode Nerd Font"
size = 14
```

### 5. **CaskaydiaCove Nerd Font** (Cascadia Code)
- **Why**: Microsoft's modern terminal font, great for Windows/Mac consistency
- **Features**: Cursive italics option, powerline symbols
- **Install**: `brew install --cask font-caskaydia-cove-nerd-font`
- **Config**:
```toml
[font]
normal.family = "CaskaydiaCove Nerd Font"
size = 14
```

### 6. **Zed Mono** (From Zed Editor) 🆕
- **Why**: Optimized for modern displays and GPU rendering
- **Features**: Designed for high DPI screens, crisp rendering
- **Install**: Available from Zed editor website
- **Config**:
```toml
[font]
normal.family = "Zed Mono"
size = 14
```

## Font Features Comparison

| Font | Ligatures | Width | Best For | Modern Score |
|------|-----------|-------|----------|--------------|
| JetBrains Mono | ✅ Excellent | Medium | General coding | ⭐⭐⭐⭐⭐ |
| Monaspace | ✅ Texture Healing | Variable | Modern terminals | ⭐⭐⭐⭐⭐ |
| Iosevka | ✅ Extensive | Narrow | Dense code | ⭐⭐⭐⭐ |
| Fira Code | ✅ Classic | Medium | All-around | ⭐⭐⭐⭐ |
| CaskaydiaCove | ✅ Good | Medium | Cross-platform | ⭐⭐⭐⭐ |
| MesloLGS | ❌ None | Medium | Classic look | ⭐⭐⭐ |

## Quick Setup Script

```bash
# Install modern fonts
brew tap homebrew/cask-fonts
brew install --cask font-jetbrains-mono-nerd-font
brew install --cask font-monaspace-nerd-font
brew install --cask font-fira-code-nerd-font

# List all Nerd Fonts available
brew search nerd-font
```

## Recommended Settings for Your Themes

### For Dark Themes (Tokyo Night, Catppuccin Mocha)
```toml
[font]
normal.family = "JetBrainsMono Nerd Font"
bold.family = "JetBrainsMono Nerd Font"
italic.family = "JetBrainsMono Nerd Font"
bold_italic.family = "JetBrainsMono Nerd Font"
size = 14

# Optional: Adjust for better rendering
[font.offset]
x = 0
y = 1  # Slight vertical adjustment

[font.glyph_offset]
x = 0
y = 0
```

### For Light Theme (Catppuccin Latte)
```toml
[font]
normal.family = "MonaspaceNeon Nerd Font"
normal.style = "Regular"
bold.style = "Bold"
size = 14  # Slightly smaller for light themes

# Better spacing for light backgrounds
[font.offset]
x = 0
y = 0
```

## Testing Fonts

After installing, test the font rendering with:
```bash
# Test ligatures
echo "-> => != === ++ -- >= <="

# Test Nerd Font symbols
echo "     󰊢   󰅂"

# Test Powerline symbols
echo "        "
```