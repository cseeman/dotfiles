#!/usr/bin/env bash
#
# Point ~/.config/alacritty/font.toml at one of the files in fonts/.
# alacritty.toml imports that pointer, and Alacritty reloads when it changes.

set -euo pipefail

PROGRAM=${0##*/}
FONT_DIR=$(cd "$(dirname "${BASH_SOURCE[0]}")/fonts" && pwd)
readonly PROGRAM FONT_DIR
readonly POINTER="${ALACRITTY_FONT:-$HOME/.config/alacritty/font.toml}"

list() {
    local f name
    for f in "$FONT_DIR"/*.toml; do
        name=${f##*/}
        printf '  %s\n' "${name%.toml}"
    done
}

current() {
    [[ -L $POINTER ]] || return 1
    local target
    target=$(readlink "$POINTER")
    target=${target##*/}
    printf '%s' "${target%.toml}"
}

usage() {
    printf 'Usage: %s <font>\n\nFonts:\n' "$PROGRAM"
    list
}

main() {
    case ${1:-} in
        "")
            printf 'Current: %s\n\nFonts:\n' "$(current || printf 'none')"
            list
            ;;
        -h|--help)
            usage
            ;;
        *)
            local file="$FONT_DIR/$1.toml"
            [[ -f $file ]] || { printf '%s: unknown font %s\n\n' "$PROGRAM" "$1" >&2; usage >&2; exit 1; }
            mkdir -p "$(dirname "$POINTER")"
            ln -sfn "$file" "$POINTER"
            printf 'Switched to %s\n' "$1"
            ;;
    esac
}

main "$@"
