# Login shell: environment only. Interactive setup lives in .bashrc.

export BASH_SILENCE_DEPRECATION_WARNING=1

# Reset rather than prepend, so nested login shells (tmux) do not pile up duplicates.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/rubyonmac:$HOME/bin:$HOME/.local/bin:$PATH"

# mise-en-place for Ruby and Node versions
eval "$(mise activate bash)"

# Signing needs to know which tty to prompt on; gpg-agent itself starts on demand.
export GPG_TTY=$(tty)

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

[[ -r ~/.bashrc ]] && source ~/.bashrc
