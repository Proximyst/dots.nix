.PHONY: switch
switch:
	git add --all
	sudo nixos-rebuild switch --flake '.#desktop' --show-trace
