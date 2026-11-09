SHELL_SCRIPTS := install.sh bin/dev-session bin/git-recent bin/git-wclean bin/my-prs bin/pr-rereview \
	bin/pr-rereview-notify bin/pr-surfaces bin/pr-waiting bin/tmux-sessionizer \
	.config/tmux/switch-theme.sh .config/tmux/bin/gen-starship-palettes.sh \
	alacritty/switch-font.sh hooks/pre-push
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

# Neovim exits 0 after a config error unless told otherwise.
nvim:
	nvim --headless -u .config/nvim/init.lua -c 'if v:errmsg != "" | cquit | endif' -c quitall
