# Christine's Dotfiles and Dev Scripts

Personal configuration files and development scripts backup.

## Contents

### Shell Configuration
- `.bashrc` - Bash configuration
- `.bash_profile` - Bash profile settings
- `.zshrc` - Zsh configuration

### Development Tools
- `.gitconfig` - Git configuration
- `.gitignore_global` - Global gitignore patterns
- `.tmux.conf` - Tmux configuration
- `.gemrc` - Ruby gems configuration
- `.tool-versions` - asdf version manager configuration

### Editor Configuration
- `nvim/` - Neovim configuration
- `.viminfo` - Vim history

### Scripts
- `dev-scripts/` - Development helper scripts
  - `dev-session` - Development session management script
  - `README.md` - Scripts documentation

## Setup

To use these dotfiles on a new machine:

```bash
# Clone the repository
git clone <your-repo-url> ~/Documents/Repos/dotfiles

# Create symlinks (example)
ln -s ~/Documents/Repos/dotfiles/.bashrc ~/.bashrc
ln -s ~/Documents/Repos/dotfiles/.zshrc ~/.zshrc
# ... etc for other files
```

## Last Updated

August 18, 2025