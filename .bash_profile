# Login shell: environment only. Interactive setup lives in .bashrc.

# Nested `source ~/.bash_profile` (tmux, Cursor, `bash -l` inside a login
# shell) must not re-run PATH resets or tool hooks.
[[ -n ${_DOTFILES_PROFILE_LOADED:-} ]] && return
_DOTFILES_PROFILE_LOADED=1

export BASH_SILENCE_DEPRECATION_WARNING=1

# Reset rather than prepend, so nested login shells (tmux) do not pile up duplicates.
export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin"
export PATH="$HOME/rubyonmac:$HOME/bin:$HOME/.local/bin:$PATH"

# Shims for non-interactive login shells (Cursor agents, scripts, `bash -lc`).
# Full `mise activate` belongs in .bashrc: it installs prompt/cd hooks and
# immediately runs `hook-env`, which is how a profile can fork-bomb the user
# process table (error.SystemResources).
export PATH="$HOME/.local/share/mise/shims:$PATH"

# Signing needs to know which tty to prompt on; gpg-agent itself starts on demand.
export GPG_TTY=$(tty 2>/dev/null)

# gh's keyring is the source of truth. GITHUB_TOKEN is deliberately not exported:
# gh prefers it over the keyring, which disables `gh auth refresh` and hands a
# repo-scoped token to every subprocess. Clear any value inherited from an older
# shell so the keyring wins here too. For a one-off, run `GITHUB_TOKEN=$(gh auth token) cmd`.
unset GITHUB_TOKEN

[[ -r ~/.bashrc ]] && source ~/.bashrc
