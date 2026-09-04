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

# fzf walks with fd so it respects .gitignore, and previews files with bat.
# Neovim's :Files picks up FZF_DEFAULT_COMMAND too.
export FZF_DEFAULT_COMMAND='fd --type f --hidden --follow --exclude .git'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
export FZF_ALT_C_COMMAND='fd --type d --hidden --follow --exclude .git'
export FZF_CTRL_T_OPTS="--preview 'bat --style=numbers --color=always --line-range :200 {}'"
if command -v fzf >/dev/null 2>&1; then
    eval "$(fzf --bash)"
fi

if command -v zoxide >/dev/null 2>&1; then
    eval "$(zoxide init bash)"
fi

if command -v starship >/dev/null 2>&1; then
    eval "$(starship init bash)"
fi

# Bundler cannot read gh's keyring, so private GitHub gems need the credential
# passed explicitly (host uppercased, dots doubled to underscores). The login
# comes from github.user in ~/.gitconfig.local. Skip when a parent shell
# already exported it so nested panes do not each hit the keychain.
if [[ -z ${BUNDLE_RUBYGEMS__PKG__GITHUB__COM:-} ]] && command -v gh >/dev/null 2>&1; then
    _gh_user=$(git config --get github.user 2>/dev/null || true)
    _gh_token=$(gh auth token 2>/dev/null || true)
    [[ -n $_gh_user && -n $_gh_token ]] && export BUNDLE_RUBYGEMS__PKG__GITHUB__COM="$_gh_user:$_gh_token"
    unset _gh_user _gh_token
fi

# Aliases
alias vim="nvim"
if command -v eza >/dev/null 2>&1; then
    alias ls='eza --group-directories-first'
    alias ll='eza -l --git --group-directories-first'
    alias la='eza -la --git --group-directories-first'
    alias lt='eza --tree --level=2 --group-directories-first'
fi
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

# Machine-specific additions, not tracked
[[ -r ~/.bashrc.local ]] && source ~/.bashrc.local
