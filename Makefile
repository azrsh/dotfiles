DEFAULT_CONFIGS:=vim tmux fish

.ONESHELL:

config:
	stow -v $(DEFAULT_CONFIGS)

.PHONY: config
