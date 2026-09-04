export BASH_SILENCE_DEPRECATION_WARNING=1

export BASH_CONF="bashrc"
#export PATH="/usr/local/bin:$PATH"
#export PATH="$GEM_HOME/bin:$PATH"

# OpenSSL@3
# To make OpenSSL@3 first
#export PATH="/usr/local/opt/openssl@3/bin:$PATH"
# For compilers to find openssl@3 you may need to set:
#export LDFLAGS="-L/usr/local/opt/openssl@3/lib"
#export CPPFLAGS="-I/usr/local/opt/openssl@3/include"
# For pkg-config to find openssl@3 you may need to set:
#export PKG_CONFIG_PATH="/usr/local/opt/openssl@3/lib/pkgconfig"

#source /usr/local/share/chruby/chruby.sh
#source /usr/local/share/chruby/auto.sh
#source ~/.git-completion.bash

alias vim="nvim"
alias dev="/Users/christine/Documents/Repos/dev-scripts/dev-session"
#alias l='exa'
#alias ls='exa -a'

#[[ -f ~/.bash-preexec.sh ]] && source ~/.bash-preexec.sh
eval "$(starship init bash)"

# asdf completions (disabled - using mise instead)
# . <(asdf completion bash)

# mise completions
eval "$(mise completion bash)"

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
# Clear screen aliases
alias cls='clear && tmux clear-history 2>/dev/null || clear'
alias cl='clear'

# Function for complete clear
clearall() {
    clear
    if [ -n "$TMUX" ]; then
        tmux clear-history
    fi
}

# gh's keyring is the source of truth. GITHUB_TOKEN is deliberately not exported:
# gh prefers it over the keyring, which disables `gh auth refresh` and hands a
# repo-scoped token to every subprocess. Clear any value inherited from an older
# shell so the keyring wins here too. For a one-off, run `GITHUB_TOKEN=$(gh auth token) cmd`.
unset GITHUB_TOKEN

# Bundler cannot read gh's keyring, so private SOFware gems need the credential
# passed explicitly (host uppercased, dots doubled to underscores).
if command -v gh >/dev/null 2>&1; then
    _gh_token=$(gh auth token 2>/dev/null)
    [ -n "$_gh_token" ] && export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="cseeman:$_gh_token"
    unset _gh_token
fi

# View markdown files through glow's pager (scroll/search), but keep the bare
# TUI and piped output untouched.
glow() {
    if [ -t 1 ] && [ "$#" -gt 0 ]; then
        command glow -p "$@"
    else
        command glow "$@"
    fi
}
