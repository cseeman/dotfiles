# Minimal zsh, kept in step with .bashrc for the rare times zsh is the shell.

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/rubyonmac:$HOME/bin:$HOME/.local/bin:$PATH"

eval "$(mise activate zsh)"
eval "$(fzf --zsh)"
eval "$(starship init zsh)"

alias vim="nvim"
alias dev="dev-session"
