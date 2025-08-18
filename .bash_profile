# Suppress bash deprecation warning on macOS
export BASH_SILENCE_DEPRECATION_WARNING=1

# Source bashrc if it exists
[[ -s ~/.bashrc ]] && source ~/.bashrc

# =============================================================================
# PATH Configuration
# =============================================================================

# Start with system paths
export PATH="/usr/local/bin:/opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:/bin:/usr/sbin:/sbin"

# Add Homebrew paths
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$PATH"

# Add ASDF for version management
export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# Add local bin directory (this was your issue - needs to be expanded)
export PATH="$HOME/.local/bin:$PATH"

# Add custom Ruby on Mac directory
export PATH="$HOME/rubyonmac:$PATH"

# =============================================================================
# Development Tools
# =============================================================================

# Node.js version management with nodenv
eval "$(nodenv init -)"
nodenv global 20.18.1

# =============================================================================
# Git Configuration
# =============================================================================

# Git autocomplete
[ -f /usr/local/etc/bash_completion ] && . /usr/local/etc/bash_completion || {
    # if not found in /usr/local/etc, try the brew --prefix location
    [ -f "$(brew --prefix)/etc/bash_completion.d/git-completion.bash" ] && \
        . $(brew --prefix)/etc/bash_completion.d/git-completion.bash
}

# =============================================================================
# Fuzzy Finder (fzf)
# =============================================================================

# Set up fzf key bindings and fuzzy completion
eval "$(fzf --bash)"

# =============================================================================
# GPG Configuration
# =============================================================================

# GPG Signing Key user agent setup
export GPG_TTY=$(tty)
[ -f ~/.gnupg/gpg-agent-info ] && source ~/.gnupg/gpg-agent-info
if [ -S "${GPG_AGENT_INFO%%:*}" ]; then
    export GPG_AGENT_INFO
else
    eval $( gpg-agent --daemon --options ~/.gnupg/gpg-agent.conf )
fi
