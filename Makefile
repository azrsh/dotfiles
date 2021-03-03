DEFAULT_CONFIGS:=vim tmux fish

.ONESHELL:

config: $(DEFAULT_CONFIGS:%=config-%)

config-%: dependency 
	stow -v $(@:config-%=%)

dependency:
	apt-get update
	apt-get install stow $(CONFIGS) -y

.PHONY: config config-% dependency
