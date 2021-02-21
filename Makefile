CONFIGS:=vim tmux fish

.ONESHELL:

config: dependency 
	stow -v $(CONFIGS)

dependency:
	apt-get update
	apt-get install stow $(CONFIGS) -y

.PHONY: config dependency
