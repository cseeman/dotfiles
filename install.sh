#!/usr/bin/env bash
#
# Link this repo's configs into $HOME and install what they depend on.
# Safe to re-run: links already in place are skipped, and anything it would
# replace is moved into ~/.dotfiles-backup/<timestamp>/ first.

set -euo pipefail

DOTFILES=$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)
readonly DOTFILES
BACKUP_DIR="$HOME/.dotfiles-backup/$(date +%Y%m%d-%H%M%S)"
readonly BACKUP_DIR
readonly TPM_DIR="$DOTFILES/.config/tmux/plugins/tpm"
readonly PLUG_VIM="$HOME/.local/share/nvim/site/autoload/plug.vim"
readonly DEFAULT_THEME="equinox-dawn"
readonly DEFAULT_FONT="maple"
readonly FONT_POINTER="$HOME/.config/alacritty/font.toml"

DRY_RUN=0
WITH_BREW=1

# repo path|target path. One line per link; directories link as a whole.
LINKS="
.bashrc|$HOME/.bashrc
.bash_profile|$HOME/.bash_profile
.zshrc|$HOME/.zshrc
.zprofile|$HOME/.zprofile
.gitconfig|$HOME/.gitconfig
.gitignore_global|$HOME/.gitignore_global
.gemrc|$HOME/.gemrc
.tool-versions|$HOME/.tool-versions
.config/tmux|$HOME/.config/tmux
.config/nvim|$HOME/.config/nvim
.config/starship.toml|$HOME/.config/starship.toml
.config/glow/glow.yml|$HOME/Library/Preferences/glow/glow.yml
alacritty/alacritty.toml|$HOME/.config/alacritty/alacritty.toml
.claude/CLAUDE.md|$HOME/.claude/CLAUDE.md
.claude/CLAUDE-user-preferences.md|$HOME/.claude/CLAUDE-user-preferences.md
dev-scripts/dev-session|$HOME/bin/dev-session
"

usage() {
    cat <<USAGE
Usage: ${0##*/} [--dry-run] [--no-brew]

  --dry-run   print what would change without touching anything
  --no-brew   skip 'brew bundle'
USAGE
}

log()  { printf '  %-8s %s\n' "$1" "$2"; }
run()  { [[ $DRY_RUN == 1 ]] || "$@"; }

link_one() {
    local src="$DOTFILES/$1" dst=$2
    [[ -e $src ]] || { log "missing" "$src"; return 1; }

    if [[ -L $dst && $(readlink "$dst") == "$src" ]]; then
        log "ok" "$dst"
        return 0
    fi
    if [[ -e $dst || -L $dst ]]; then
        local keep="$BACKUP_DIR/${dst#"$HOME"/}"
        log "backup" "$dst -> $keep"
        run mkdir -p "$(dirname "$keep")"
        run mv "$dst" "$keep"
    fi
    run mkdir -p "$(dirname "$dst")"
    run ln -s "$src" "$dst"
    log "link" "$dst -> $src"
}

link_all() {
    printf 'Symlinks\n'
    local src dst
    while IFS='|' read -r src dst; do
        [[ -n $src ]] || continue
        link_one "$src" "$dst"
    done <<< "$LINKS"
}

install_brew() {
    printf '\nHomebrew\n'
    if ! command -v brew >/dev/null 2>&1; then
        log "skip" "brew not found; see https://brew.sh then re-run"
        return 0
    fi
    run brew bundle --file "$DOTFILES/Brewfile" --no-upgrade
}

install_tmux_plugins() {
    printf '\ntmux plugins\n'
    if [[ ! -d $TPM_DIR ]]; then
        run git clone --quiet https://github.com/tmux-plugins/tpm "$TPM_DIR"
        log "clone" "$TPM_DIR"
    else
        log "ok" "$TPM_DIR"
    fi
    if command -v tmux >/dev/null 2>&1 && [[ -x $TPM_DIR/bin/install_plugins ]]; then
        run "$TPM_DIR/bin/install_plugins" >/dev/null
        log "ok" "plugins installed"
    fi
}

select_theme() {
    printf '\ntmux theme\n'
    local active="$DOTFILES/.config/tmux/config/theme.conf"
    if [[ -L $active ]]; then
        log "ok" "$(basename "$(readlink "$active")")"
        return 0
    fi
    run "$DOTFILES/.config/tmux/switch-theme.sh" "$DEFAULT_THEME"
}

select_font() {
    printf '\nAlacritty font\n'
    if [[ -L $FONT_POINTER ]]; then
        log "ok" "$(basename "$(readlink "$FONT_POINTER")" .toml)"
        return 0
    fi
    run "$DOTFILES/alacritty/switch-font.sh" "$DEFAULT_FONT"
}

install_vim_plug() {
    printf '\nNeovim\n'
    if [[ ! -f $PLUG_VIM ]]; then
        run curl -fsSLo "$PLUG_VIM" --create-dirs \
            https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
        log "fetch" "vim-plug"
    else
        log "ok" "vim-plug"
    fi
    if command -v nvim >/dev/null 2>&1; then
        run nvim --headless +PlugInstall +qa
        log "ok" "plugins installed"
    fi
}

main() {
    while [[ $# -gt 0 ]]; do
        case $1 in
            -n|--dry-run) DRY_RUN=1 ;;
            --no-brew)    WITH_BREW=0 ;;
            -h|--help)    usage; return 0 ;;
            *)            usage >&2; return 1 ;;
        esac
        shift
    done

    [[ $DRY_RUN == 0 ]] || printf 'Dry run: reporting what would change.\n\n'
    link_all
    [[ $WITH_BREW == 1 ]] && install_brew
    install_tmux_plugins
    select_theme
    select_font
    install_vim_plug

    printf '\nDone. Open a new shell to pick up the changes.\n'
}

main "$@"
