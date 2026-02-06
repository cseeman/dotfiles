export BASH_SILENCE_DEPRECATION_WARNING=1

export BASH_CONF="bashrc"
#export PATH="/usr/local/bin:$PATH"
#export PATH="$GEM_HOME/bin:$PATH"
# GitHub token removed for security - set in environment if needed

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
