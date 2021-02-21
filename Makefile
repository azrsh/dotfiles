CONFIGS:=vim tmux bash fish

.ONESHELL:

config: dependency 
	stow -v $(CONFIGS)

dependency:
	apt-get update
	apt-get install stow $(CONFIGS) -y