# Login zsh: environment only. Interactive setup lives in .zshrc.
# Static Homebrew env — `eval "$(brew shellenv)"` forks brew on every login.

export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_CELLAR="/opt/homebrew/Cellar"
export HOMEBREW_REPOSITORY="/opt/homebrew"
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/rubyonmac:$HOME/bin:$HOME/.local/bin:$HOME/.local/share/mise/shims:$PATH"
