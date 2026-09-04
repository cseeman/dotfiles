SHELL_SCRIPTS := install.sh bin/dev-session bin/git-recent \
	.config/tmux/switch-theme.sh .config/tmux/bin/gen-starship-palettes.sh \
	alacritty/switch-font.sh
TMUX_CONFS := .config/tmux/config/options.conf .config/tmux/config/keybindings.conf \
	$(wildcard .config/tmux/config/theme-*.conf)
SOCKET := dotfiles-check-$(shell id -u)

.PHONY: check shellcheck tmux nvim

check: shellcheck tmux nvim

shellcheck:
	shellcheck -s bash $(SHELL_SCRIPTS)

# Sources each config into a scratch server on its own socket; the live server
# is never touched.
tmux:
	tmux -L $(SOCKET) -f /dev/null new-session -d 'sleep 60'
	status=0; for f in $(TMUX_CONFS); do tmux -L $(SOCKET) source-file $$f || status=1; done; \
	tmux -L $(SOCKET) kill-server; exit $$status

nvim:
	nvim --headless -u .config/nvim/init.lua -c quitall
