{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    catppuccin.url = "github:catppuccin/nix";
    neovim-nightly-overlay = {
      url = "github:nix-community/neovim-nightly-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... } @ inputs:
    let
      sys-conf = import ./users/mariell/config.nix;
      system = "x86_64-linux";
      inherit inputs;
    in
    {
      nixosConfigurations.mariell = inputs.nixpkgs.lib.nixosSystem {
        inherit system;

        modules = [
          # Set up the system itself.
          ({ config, pkgs, lib, ... }: (
            import ./machines/desktop {
              inherit inputs; # pass in the flake inputs
              inherit config pkgs lib;
            }
          ))

          # Set up home-manager.
          inputs.home-manager.nixosModules.home-manager
          {
            home-manager = {
              # Prefer the system-level pkgs, as opposed to a separate set.
              useGlobalPkgs = true;
              # Enable installing packages via users.users.<...>.packages.
              useUserPackages = true;
              # Add extra arguments passed to ALL home-manager modules.
              extraSpecialArgs = {
                inherit system;
                inherit sys-conf;
              };
            };
          }
        ];
      };

      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    };
}
