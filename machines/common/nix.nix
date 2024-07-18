{ lib, inputs, ... }:

let
  flakeInputs = lib.filterAttrs (name: value: (value ? outputs) && (name != "self")) inputs;
  registry = builtins.mapAttrs (name: v: { flake = v; }) flakeInputs;
in
{
  nixpkgs.config.allowUnfree = true;

  nix = {
    inherit registry;

    # Enable flakes
    settings.experimental-features = [ "nix-command" "flakes" ];

    # Clean up unused revisions & packages.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 14d";
    };
    # Replace duplicates in /nix/store with hard-links.
    optimise = {
      automatic = true;
      dates = [ "17:55" ];
    };
    settings.auto-optimise-store = true;
    # Use as many cores as possible.
    settings.build-cores = 8;
    settings.max-jobs = "auto";
    # Run nix jobs in a sandbox
    settings.sandbox = true;
  };
}
