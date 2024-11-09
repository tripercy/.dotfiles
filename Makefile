XDG_CONFIG_HOME ?= "${HOME}/.config"

.prony: 

sync:
	cp .zshrc ~/.zshrc
	mkdir -p ${XDG_CONFIG_HOME}/tmux
	cp tmux.conf ${XDG_CONFIG_HOME}/tmux/tmux.conf
	cp nix/darwin/* ~/.config/nix/

build_darwin:
	darwin-rebuild switch --flake ~/.config/nix#m1air
