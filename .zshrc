# Minimal zsh, kept in step with .bashrc for the rare times zsh is the shell.

[[ -o interactive ]] || return

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

alias vim="nvim"
alias dev="dev-session"

# Machine-specific additions, not tracked
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
