.PHONY: switch
switch:
	git add --all
	nixos-rebuild switch --flake '.#desktop' --show-trace --use-remote-sudo

.PHONY: darwin
darwin:
	git add --all
	nix run nix-darwin -- switch --flake '.#work' --show-trace
