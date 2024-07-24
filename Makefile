.PHONY: switch
switch:
	git add --all
	sudo nixos-rebuild switch --flake '.#desktop' --show-trace

.PHONY: darwin
darwin:
	git add --all
	nix run nix-darwin -- switch --flake '.#work' --show-trace
