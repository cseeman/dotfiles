# Theming

One switcher changes the tmux theme and the Starship prompt palette together.

```
~/.config/tmux/switch-theme.sh equinox      # switch both
~/.config/tmux/switch-theme.sh --list       # what is installed
~/.config/tmux/switch-theme.sh --current    # active theme + palette, warns on mismatch
~/.config/tmux/switch-theme.sh --menu       # picker (also bound to prefix + T)
```

## How it fits together

| File | Role |
|---|---|
| `themes.registry` | The theme list. Single source of truth. |
| `switch-theme.sh` | Reads the registry, switches tmux and Starship. |
| `bin/gen-starship-palettes.sh` | Generates Starship palettes from the tmux themes. |
| `config/theme-*.conf` | One tmux theme each. Colors only. |
| `config/theme.conf` | Symlink to the active theme. Not edited by hand. |
| `../starship.toml` | Prompt config; holds every palette, one `palette =` line selects. |

tmux switches by repointing `config/theme.conf` and sourcing the config.
Starship switches by rewriting its `palette =` line, which every shell picks up
on its next prompt, since Starship re-reads its config on each prompt render.

## Adding a theme

1. Write `config/theme-<name>.conf`. Colors only: no `default-terminal`, no
   `command-alias`, no other global settings. Those live in `config/options.conf`
   so a theme switch cannot quietly change unrelated behavior.
2. Add a line to `themes.registry`: `name|file|mode|description`.
3. Run `bin/gen-starship-palettes.sh` to generate the matching prompt palette.

The generator sources each theme into a throwaway tmux server and reads the
*resolved* colors back out, because the themes name their colors differently
(`mauve`, `iris`, `plum` all mean roughly the same thing). It maps tmux roles
onto prompt roles, so any theme works without a per-theme mapping table.

Palettes live between marker comments in `starship.toml` and are overwritten on
each run. To change a prompt color, change the tmux theme and regenerate; edits
inside the generated block do not survive.

## Light themes

Light themes also remap ANSI colors 7 and 8, which some tools (Claude Code among
them) use for muted status text. The terminal defaults are tuned for dark
backgrounds and fall to roughly 2.3:1 on a light one. Dark themes reset the pair
back to the terminal's own values.
