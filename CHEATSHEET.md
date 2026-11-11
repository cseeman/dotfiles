# Cheat sheet

Type `cheat` in any shell to open this.

## Finding things

| Keys | What |
|---|---|
| `Ctrl-T` | Fuzzy-pick a file under the current directory, with a preview. Inserts the path. |
| `Ctrl-R` | Fuzzy search shell history. |
| `Esc c` | Fuzzy-pick a directory and cd into it. |
| `vim **<Tab>` | Fuzzy completion for any command's argument. |
| `z qual` | Jump to the most-used directory matching `qual` (zoxide). |
| `z qual feat` | Same, matching both fragments in order. |
| `zi` | Pick a directory interactively from zoxide's list. |

## Listing

| Command | What |
|---|---|
| `ls` | eza, directories first |
| `ll` | Long form with git status column |
| `la` | Long form including dotfiles |
| `lt` | Tree, two levels deep |

## tmux (prefix is `Ctrl-t`)

| Keys | What |
|---|---|
| `prefix j` | Pick a repo or worktree and jump to its dev-session (creates it if needed) |
| `prefix T` | Theme picker (also switches Starship, Alacritty, glow, Neovim) |
| `prefix t` | Toggle the status bar |
| `prefix z` | Zoom the current pane |
| `prefix \|` / `prefix -` | Split side by side / top and bottom |
| `Ctrl-h/j/k/l` | Move between panes and Neovim splits (`Ctrl-j` stays with Claude) |
| `prefix [` then `v`, `y` | Copy mode: select, yank to the clipboard |
| `prefix r` | Reload tmux config |
| `prefix R` / `prefix S` | Restore / save sessions (resurrect) |

## Git

| Command | What |
|---|---|
| `git recent` | Branches by last commit, as many as fit the screen |
| `git recent 5` | Just five |
| `git wclean ../repo-feature` | Remove a clean worktree, delete its branch if merged |
| `git pf` | `push --force-with-lease` |
| `git can` | Amend without editing the message |
| `git up` | `pull --rebase --autostash` |
| `git rip` | Interactive rebase, keeping merges |

Rebasing a stack updates every branch above it (`rebase.updateRefs`), and
`git push` on a new branch sets its upstream automatically.

## Reviews

| Command | What |
|---|---|
| `pr-waiting` | Open PRs across your configured repos still waiting on you, oldest first |
| `pr-waiting --all` | The same list unfiltered, the raw team queue |
| `pr-rereview` | PRs you reviewed that may need another look |
| `my-prs` | Your open and draft PRs with review decision and CI state |
| `pr-surfaces` | Authored vs reviewed by month, and how much touched a decision surface |
| `pr-surfaces --months 12` | A longer window |

Review requests land on teams, not people, and GitHub never clears one when
a teammate reviews. `pr-waiting` drops drafts, bots, and anything you have
already reviewed, so `untouched` in the SEEN column means nobody has looked
at it yet.

## Neovim (leader is Space)

| Keys | What |
|---|---|
| `Ctrl-P` / `Ctrl-G` | Fuzzy files / git-tracked files |
| `Space f` | Ripgrep the project |
| `Space b` | Switch buffer |
| `gd` | Go to definition |
| `K` | Hover docs |
| `grr` / `gri` | References / implementations |
| `grn` or `Space rn` | Rename |
| `gra` or `Space ca` | Code action |
| `Space e` | Show the diagnostic under the cursor |
| `[d` / `]d` | Previous / next diagnostic |
| `Space w` / `Space q` | Write / quit |
| `Space Enter` | Clear search highlight |

ruby-lsp starts the first time you open a `.rb` in a project with a
`Gemfile.lock`. First start in a project takes a few seconds.

## Sessions and machine

| Command | What |
|---|---|
| `dev` or `dev-session` | Two-pane tmux session for the current directory: shell left, Claude right |
| `dev -w <branch>` | The same, in that branch's own worktree (created if needed) |
| `switch-theme.sh --list` | Themes; `switch-theme.sh equinox-dawn` to switch everything |
| `switch-font.sh` | Alacritty fonts; `switch-font.sh maple` to switch |
| `make check` | Lint scripts, source tmux configs, start Neovim headless |
| `./install.sh --dry-run` | See what the installer would change on this machine |
