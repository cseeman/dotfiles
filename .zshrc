# Minimal zsh, kept in step with .bashrc for the rare times zsh is the shell.

[[ -o interactive ]] || return

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate zsh)"
fi

export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}'"
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --zsh)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init zsh)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init zsh)"
fi

alias vim="nvim"
alias dev="dev-session"
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first'
    alias ll='eza -l --git --group-directories-first'
    alias la='eza -la --git --group-directories-first'
    alias lt='eza --tree --level=2 --group-directories-first'
fi

# Machine-specific additions, not tracked
[[ -r ~/.zshrc.local ]] && source ~/.zshrc.local
