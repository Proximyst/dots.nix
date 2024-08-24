{ config, lib, inputs, ... }:

let
  cfg = config.modules.nix;
in
with lib;
{
  options.modules.nix = {
    cores = mkOption {
      description = "the amount of cores to use when building";
      example = 4;
      default = 8;
      type = types.int;
    };
  };

  config = {
    nixpkgs.config.allowUnfree = true;

    nix = {
      registry.nixpkgs = {
        from = {
          id = "nixpkgs";
          type = "indirect";
        };
        flake = inputs.nixpkgs;
      };

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
      settings.build-cores = cfg.cores;
      settings.max-jobs = "auto";
      # Run nix jobs in a sandbox
      settings.sandbox = true;
    };
  };
}
