.PHONY: switch
switch:
	sudo nixos-rebuild switch --flake '.#mariell' --show-trace
