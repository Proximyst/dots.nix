{
  inputs = {
    # Nixpkgs is the package registry of NixOS.
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    # Home-manager handles local users' configurations.
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # This just helps set up basic things with the flake.
    flake-utils.url = "github:numtide/flake-utils";

    nix-darwin = {
      url = "github:lnl7/nix-darwin/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # Various applications and whatnot.
    catppuccin.url = "github:catppuccin/nix";
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-conf = {
      url = "github:proximyst/neovim.nix";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.fenix.follows = "fenix";
    };
  };

  outputs = { self, nixpkgs, flake-utils, ... } @ inputs:
    let
      sys-conf = import ./users/mariell/config.nix;
      inherit inputs;
    in
    {
      nixosConfigurations.desktop = inputs.nixpkgs.lib.nixosSystem (
        let system = "x86_64-linux";
        in {
          inherit system;
          specialArgs = {
            inherit system inputs;
          };

          modules = [
            # Set up the machine itself
            ./machines/common
            ./machines/desktop

            # Set up home-manager for the main user
            inputs.home-manager.nixosModules.home-manager
            {
              home-manager = {
                useGlobalPkgs = true;
                useUserPackages = true;
                # These are passed to ALL home-manager modules.
                extraSpecialArgs = {
                  inherit system inputs;
                  platform = "linux";
                };
              };
            }
          ];
        }
      );

      darwinConfigurations.work = inputs.nix-darwin.lib.darwinSystem (
        let
          system = "aarch64-darwin";
          nixpkgsConf = {
            inherit system;
            config.allowUnfree = true;
            overlays = [
              inputs.fenix.overlays.default
              inputs.neovim-conf.overlays.default
            ];
          };
        in
        {
          specialArgs = {
            inherit inputs;
          };

          modules = [
            (args: import ./machines/darwin ({
              inherit inputs;
              pkgs = import nixpkgs nixpkgsConf;
            } // args))

            inputs.home-manager.darwinModules.home-manager
            {
              nixpkgs = nixpkgsConf;

              home-manager = {
                # Prefer the system-level pkgs, as opposed to a separate set.
                useGlobalPkgs = true;
                # Enable installing packages via users.users.<...>.packages.
                useUserPackages = true;
                # Add extra arguments passed to ALL home-manager modules.
                extraSpecialArgs = {
                  inherit system inputs;
                  platform = "darwin";
                };

                users.mariellh = {
                  imports = [ ./users/mariellh-work ];
                };
              };
            }
          ];
        }
      );
    }
    // (flake-utils.lib.eachDefaultSystem (system: {
      formatter = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    }));
}
