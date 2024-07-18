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

    # Various applications and whatnot.
    catppuccin.url = "github:catppuccin/nix";
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
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
