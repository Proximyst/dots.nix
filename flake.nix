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
    fenix = {
      url = "github:nix-community/fenix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    walker = {
      url = "github:abenz1267/walker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = inputs @ { nixpkgs, self, home-manager, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
      overlays = [
        inputs.neovim-nightly-overlay.overlay
        inputs.fenix.overlays.default
      ];
    in
    {
      nixosConfigurations = {
        mariell = lib.nixosSystem rec {
          inherit system;
          modules = [
            { nixpkgs.overlays = overlays; }
            ./nixos/configuration.nix
            inputs.catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mariell = {
                imports = [
                  ./home/home.nix
                  inputs.catppuccin.homeManagerModules.catppuccin
                  inputs.walker.homeManagerModules.walker
                ];
              };
            }
          ];
        };
      };
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    };
}
