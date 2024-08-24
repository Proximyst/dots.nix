.PHONY: switch
switch:
	git add --all
	nixos-rebuild switch --flake '.#desktop' --show-trace --use-remote-sudo

.PHONY: update
update:
	nix flake update && nix flake lock
	(cd hosts/modules/devshells/ && nix flake update && nix flake lock)

.PHONY: darwin
darwin:
	git add --all
	nix run nix-darwin -- switch --flake '.#work' --show-trace
