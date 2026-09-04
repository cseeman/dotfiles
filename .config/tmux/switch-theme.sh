#!/usr/bin/env bash
#
# Unified theme switcher for tmux and Starship.
#
# Themes are declared once in themes.registry; this script and
# bin/gen-starship-palettes.sh both read it, so the tmux theme name and the
# Starship palette name are always the same string.
#
# tmux switches by repointing config/theme.conf at a theme file and sourcing
# the config. Starship switches by rewriting its single `palette =` line, which
# every shell picks up on its next prompt: Starship runs as a fresh process per
# prompt and re-reads the config each time.
#
# The theme's mode (light or dark) is also written to ~/.config/theme-mode for
# tools that only need to know that much: Neovim reads it for 'background', and
# glow's style line is rewritten here directly. Alacritty follows through a
# pointer file that imports one of the alacritty-theme files.

set -euo pipefail

PROGRAM=${0##*/}
readonly PROGRAM

TMUX_DIR=${TMUX_DIR:-$HOME/.config/tmux}
readonly TMUX_DIR
readonly THEME_DIR="$TMUX_DIR/config"
readonly REGISTRY="$TMUX_DIR/themes.registry"
readonly ACTIVE_LINK="$THEME_DIR/theme.conf"
readonly STARSHIP_TOML="${STARSHIP_TOML:-$HOME/.config/starship.toml}"
readonly MODE_FILE="${THEME_MODE_FILE:-$HOME/.config/theme-mode}"
readonly GLOW_YML="${GLOW_YML:-$HOME/Library/Preferences/glow/glow.yml}"
readonly ALACRITTY_THEMES="${ALACRITTY_THEMES:-$HOME/.config/alacritty/themes/themes}"
readonly ALACRITTY_POINTER="${ALACRITTY_POINTER:-$HOME/.config/alacritty/theme.toml}"
readonly ALACRITTY_DARK_DEFAULT="carbonfox"
readonly ALACRITTY_LIGHT_DEFAULT="dayfox"

# Muted greys for ANSI 7 and 8. Tools such as Claude Code use these for status
# text; the terminal defaults are tuned for dark backgrounds and drop to ~2.3:1
# on a light theme, so light themes get a darker pair and dark themes get the
# terminal's own values back.
readonly LIGHT_ANSI7='66/5c/54'
readonly LIGHT_ANSI8='50/49/45'

# Parallel arrays: bash 3.2 ships on macOS and has no associative arrays.
THEME_NAMES=()
THEME_FILES=()
THEME_MODES=()
THEME_DESCS=()
THEME_ALACRITTY=()

die() { printf '%s: %s\n' "$PROGRAM" "$*" >&2; exit 1; }
warn() { printf '%s: %s\n' "$PROGRAM" "$*" >&2; }

load_registry() {
    [[ -f $REGISTRY ]] || die "registry not found: $REGISTRY"
    local name file mode desc alacritty
    while IFS='|' read -r name file mode desc alacritty; do
        [[ -z $name || $name == \#* ]] && continue
        THEME_NAMES+=("$name")
        THEME_FILES+=("$file")
        THEME_MODES+=("$mode")
        THEME_DESCS+=("$desc")
        THEME_ALACRITTY+=("$alacritty")
    done < "$REGISTRY"
    [[ ${#THEME_NAMES[@]} -gt 0 ]] || die "registry is empty: $REGISTRY"
}

# Index of a theme name, or -1. Callers read the parallel arrays directly,
# which avoids the subshell that made the old get_theme_* helpers lose $mode.
theme_index() {
    local i
    for i in "${!THEME_NAMES[@]}"; do
        [[ ${THEME_NAMES[$i]} == "$1" ]] && { printf '%s' "$i"; return 0; }
    done
    printf '%s' -1
}

installed() { [[ -f "$THEME_DIR/${THEME_FILES[$1]}" ]]; }

current_theme() {
    [[ -L $ACTIVE_LINK ]] || return 1
    local target base i
    target=$(readlink "$ACTIVE_LINK")
    base=${target##*/}
    for i in "${!THEME_FILES[@]}"; do
        [[ ${THEME_FILES[$i]} == "$base" ]] && { printf '%s' "${THEME_NAMES[$i]}"; return 0; }
    done
    return 1
}

current_palette() {
    [[ -f $STARSHIP_TOML ]] || return 1
    sed -n "s/^palette *= *['\"]\\([^'\"]*\\)['\"].*/\\1/p" "$STARSHIP_TOML" | head -1
}

# Source the theme into a scratch server first. A theme with a syntax error
# would otherwise take the live config down with it.
validate_theme() {
    local file=$1 socket="theme-check-$$" output
    tmux -L "$socket" -f /dev/null new-session -d "sleep 5" >/dev/null 2>&1 \
        || { warn "could not start scratch tmux server; skipping validation"; return 0; }
    output=$(tmux -L "$socket" source-file "$file" 2>&1) || true
    tmux -L "$socket" kill-server >/dev/null 2>&1 || true
    [[ -z $output ]] || die "theme file has errors: $output"
}

apply_tmux() {
    local idx=$1 file="$THEME_DIR/${THEME_FILES[$1]}"
    validate_theme "$file"
    ln -sfn "$file" "$ACTIVE_LINK"

    if tmux has-session >/dev/null 2>&1; then
        tmux source-file "$TMUX_DIR/tmux.conf" >/dev/null 2>&1 \
            || warn "tmux reloaded with errors; run: tmux source-file $TMUX_DIR/tmux.conf"
        # Record the active theme so status lines, menus and other tools can
        # query it without resolving the symlink.
        tmux set-option -g @theme "${THEME_NAMES[$idx]}" 2>/dev/null || true
        tmux set-option -g @theme-mode "${THEME_MODES[$idx]}" 2>/dev/null || true
    fi
}

apply_starship() {
    local name=$1
    [[ -f $STARSHIP_TOML ]] || { warn "starship config not found; skipping"; return 0; }
    if ! grep -q "^\[palettes\.$name\]" "$STARSHIP_TOML"; then
        warn "no starship palette '$name'; run bin/gen-starship-palettes.sh"
        return 0
    fi
    local tmp
    tmp=$(mktemp)
    sed "s/^palette *=.*/palette = '$name'/" "$STARSHIP_TOML" > "$tmp"
    grep -q "^palette = '$name'$" "$tmp" || { rm -f "$tmp"; die "failed to set starship palette"; }
    cat "$tmp" > "$STARSHIP_TOML"   # preserve the symlink rather than replacing it
    rm -f "$tmp"
}

apply_mode() {
    mkdir -p "$(dirname "$MODE_FILE")"
    printf '%s\n' "$1" > "$MODE_FILE"
}

apply_glow() {
    local mode=$1 tmp
    [[ -f $GLOW_YML ]] || return 0
    tmp=$(mktemp)
    sed "s/^style: .*/style: \"$mode\"/" "$GLOW_YML" > "$tmp"
    cat "$tmp" > "$GLOW_YML"   # preserve the symlink rather than replacing it
    rm -f "$tmp"
}

apply_alacritty() {
    local idx=$1 mode=$2 name=${THEME_ALACRITTY[$1]}
    [[ -d $ALACRITTY_THEMES ]] || return 0
    if [[ -z $name ]]; then
        [[ $mode == light ]] && name=$ALACRITTY_LIGHT_DEFAULT || name=$ALACRITTY_DARK_DEFAULT
    fi
    local file="$ALACRITTY_THEMES/$name.toml"
    [[ -f $file ]] || { warn "no alacritty theme '$name' in $ALACRITTY_THEMES; skipping"; return 0; }
    ln -sfn "$file" "$ALACRITTY_POINTER"
}

# shellcheck disable=SC1003  # the \\ is the OSC string terminator, not a quote
apply_ansi() {
    # Only meaningful when stdout is a terminal; from tmux run-shell these
    # would otherwise be captured as literal text.
    [[ -t 1 ]] || return 0
    if [[ $1 == light ]]; then
        printf '\033]4;7;rgb:%s\033\\' "$LIGHT_ANSI7"
        printf '\033]4;8;rgb:%s\033\\' "$LIGHT_ANSI8"
    else
        printf '\033]104;7\033\\'
        printf '\033]104;8\033\\'
    fi
}

cmd_list() {
    local active i marker
    active=$(current_theme || true)
    printf 'Available themes:\n'
    for mode in dark light; do
        printf '\n  %s\n' "$mode"
        for i in "${!THEME_NAMES[@]}"; do
            [[ ${THEME_MODES[$i]} == "$mode" ]] || continue
            installed "$i" || continue
            marker='   '
            [[ ${THEME_NAMES[$i]} == "$active" ]] && marker=' * '
            printf '%s%-16s %s\n' "$marker" "${THEME_NAMES[$i]}" "${THEME_DESCS[$i]}"
        done
    done
    printf '\n'
}

cmd_current() {
    local theme palette
    theme=$(current_theme || printf '<unknown>')
    palette=$(current_palette || printf '<none>')
    printf 'tmux theme:       %s\n' "$theme"
    printf 'starship palette: %s\n' "$palette"
    printf 'mode:             %s\n' "$(cat "$MODE_FILE" 2>/dev/null || printf '<unset>')"
    if [[ $theme != "$palette" ]]; then
        printf '\nMismatch: run "%s %s" to bring them back in sync.\n' "$PROGRAM" "$theme"
        return 1
    fi
}

# Build the menu from the registry so it can never drift from --list.
cmd_menu() {
    [[ -n ${TMUX:-} ]] || die "--menu requires a tmux session"
    local args=() i key n=0
    local keys='123456789abcdefghijklmnopqrstuvwxyz'
    local last_mode=''
    for i in "${!THEME_NAMES[@]}"; do
        installed "$i" || continue
        if [[ ${THEME_MODES[$i]} != "$last_mode" ]]; then
            # A separator also ends tmux's flag parsing, which would otherwise
            # read the leading "-" of a non-selectable header as an option.
            args+=("")
            args+=("-#[nodim,align=centre]${THEME_MODES[$i]}" '' '')
            last_mode=${THEME_MODES[$i]}
        fi
        key=${keys:$n:1}
        args+=("${THEME_NAMES[$i]}" "$key" "run-shell '$TMUX_DIR/switch-theme.sh ${THEME_NAMES[$i]}'")
        n=$((n + 1))
    done
    tmux display-menu -T ' theme ' -x C -y C "${args[@]}"
}

cmd_switch() {
    local name=$1 idx
    idx=$(theme_index "$name")
    [[ $idx -ge 0 ]] || { printf '%s: unknown theme %s\n\n' "$PROGRAM" "$name" >&2; cmd_list >&2; exit 1; }
    installed "$idx" || die "theme file missing: $THEME_DIR/${THEME_FILES[$idx]}"

    apply_tmux "$idx"
    [[ $SKIP_STARSHIP == 1 ]] || apply_starship "$name"
    apply_mode "${THEME_MODES[$idx]}"
    apply_glow "${THEME_MODES[$idx]}"
    apply_alacritty "$idx" "${THEME_MODES[$idx]}"
    apply_ansi "${THEME_MODES[$idx]}"

    printf 'Switched to %s (%s)\n' "$name" "${THEME_MODES[$idx]}"
    [[ $SKIP_STARSHIP == 1 ]] || printf 'Starship palette applies at the next prompt.\n'
    [[ -n ${TMUX:-} ]] && tmux display-message "theme: $name" || true
}

usage() {
    cat <<USAGE
$PROGRAM - switch the tmux theme, Starship palette, Alacritty theme, and light/dark mode together

Usage:
  $PROGRAM <theme>        switch to a theme
  $PROGRAM --list         list installed themes by mode
  $PROGRAM --current      show the active theme and palette
  $PROGRAM --menu         open an interactive picker (inside tmux)
  $PROGRAM --help         show this message

Options:
  --no-starship           change the tmux theme only

Themes are declared in themes.registry. After adding one, run
bin/gen-starship-palettes.sh to generate its Starship palette.
USAGE
}

main() {
    load_registry
    SKIP_STARSHIP=0
    local positional=()

    while [[ $# -gt 0 ]]; do
        case $1 in
            -h|--help)    usage; return 0 ;;
            -l|--list)    cmd_list; return 0 ;;
            -c|--current) cmd_current; return $? ;;
            -m|--menu)    cmd_menu; return 0 ;;
            --no-starship) SKIP_STARSHIP=1 ;;
            --)           shift; positional+=("$@"); break ;;
            -*)           die "unknown option: $1 (try --help)" ;;
            *)            positional+=("$1") ;;
        esac
        shift
    done

    case ${#positional[@]} in
        0) cmd_list; printf 'Usage: %s <theme>   (--help for more)\n' "$PROGRAM" ;;
        1) cmd_switch "${positional[0]}" ;;
        *) die "expected one theme name, got ${#positional[@]}" ;;
    esac
}

main "$@"
