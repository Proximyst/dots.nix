{
  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    catppuccin.url = "github:catppuccin/nix";
  };

  outputs = { nixpkgs, self, home-manager, catppuccin, ... }:
    let
      system = "x86_64-linux";
      pkgs = import nixpkgs {
        inherit system;
        config.allowUnfree = true;
      };
      lib = nixpkgs.lib;
    in
    {
      nixosConfigurations = {
        mariell = lib.nixosSystem rec {
          inherit system;
          modules = [
            ./nixos/configuration.nix
            catppuccin.nixosModules.catppuccin
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.mariell = {
                imports = [
                  ./home/home.nix
                  catppuccin.homeManagerModules.catppuccin
                ];
              };
            }
          ];
        };
      };
      formatter."${system}" = nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    };
}
