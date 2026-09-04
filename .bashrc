# Interactive shell setup. Environment and PATH live in .bash_profile.

[[ $- == *i* ]] || return

# Completions and prompt. bash-completion@2 loads each command's completion on
# first use and needs bash 4.2+, so a stray /bin/bash pane just goes without.
if (( BASH_VERSINFO[0] >= 4 )) && [[ -r /opt/homebrew/etc/profile.d/bash_completion.sh ]]; then
    source /opt/homebrew/etc/profile.d/bash_completion.sh
fi

if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash)"
    eval "$(mise completion bash)"
fi

if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Bundler cannot read gh's keyring, so private SOFware gems need the credential
# passed explicitly (host uppercased, dots doubled to underscores). Skip when a
# parent shell already exported it so nested panes do not each hit the keychain.
if [[ -z ${BUNDLE_RUBYGEMS__PKG__GITHUB__COM:-} ]] && command -v gh >/dev/null 2>&1; then
    _gh_token=$(gh auth token 2>/dev/null)
    [ -n "$_gh_token" ] && export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="cseeman:$_gh_token"
    unset _gh_token
fi

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
