.PHONY: switch
switch:
	git add --all
	sudo nixos-rebuild switch --flake '.#mariell' --show-trace
