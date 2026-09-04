# Interactive shell setup. Environment and PATH live in .bash_profile.

[[ $- == *i* ]] || return

# Completions and prompt
[[ -r /opt/homebrew/etc/bash_completion.d/git-completion.bash ]] \
    && source /opt/homebrew/etc/bash_completion.d/git-completion.bash
eval "$(mise completion bash)"
eval "$(fzf --bash)"
eval "$(starship init bash)"

# Aliases
alias vim="nvim"
alias dev="dev-session"
alias cl='clear'
alias cls='clear && tmux clear-history 2>/dev/null || clear'

clearall() {
    clear
    if [ -n "$TMUX" ]; then
        tmux clear-history
    fi
}

# View markdown files through glow's pager (scroll/search), but keep the bare
# TUI and piped output untouched.
glow() {
    if [ -t 1 ] && [ "$#" -gt 0 ]; then
        command glow -p "$@"
    else
        command glow "$@"
    fi
}
