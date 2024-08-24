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

  outputs = { self, flake-utils, ... } @ inputs:
    let
      mkSystem = { system, hostname, host, username, ... }:
        let
          isLinux = inputs.nixpkgs.legacyPackages.${system}.stdenv.isLinux;
        in
        (if isLinux
        then inputs.nixpkgs.lib.nixosSystem
        else inputs.nix-darwin.lib.darwinSystem)
          {
            inherit system;
            specialArgs = {
              inherit system inputs username;
            };

            modules =
              let
                overlays = [
                  inputs.fenix.overlays.default
                  inputs.neovim-conf.overlays.default
                  (final: prev: {
                    my = {
                      mkDisableOption = description: (prev.lib.mkEnableOption description) // { default = true; };
                    };
                  })
                ];
              in
              [
                ({ lib, pkgs, ... }: {
                  # Don't set this on Darwin.
                  networking.hostName = lib.mkIf isLinux hostname;
                  nixpkgs.overlays = lib.mkIf isLinux overlays;
                  nixpkgs.config.allowUnfree = true;
                })

                ./hosts/modules
                host

                (if isLinux
                then inputs.home-manager.nixosModules
                else inputs.home-manager.darwinModules).home-manager
                {
                  home-manager = {
                    useGlobalPkgs = true;
                    useUserPackages = true;
                    extraSpecialArgs = {
                      inherit system inputs username;
                    };

                    users.${username} = ./home;
                  } // (if isLinux
                  then { }
                  else {
                    nixpkgs = {
                      inherit system overlays;
                      config.allowUnfree = true;
                    };
                  });
                }
              ];
          };
    in
    {
      nixosConfigurations.desktop = mkSystem {
        system = "x86_64-linux";
        hostname = "mariell-nix";
        host = ./hosts/desktop;
        username = "mariell";
      };

      # darwinConfigurations.work = mkSystem {
      #   system = "aarch64-darwin";
      #   hostname = "mariell-work";
      #   host = ./hosts/work;
      #   username = "mariellh";
      # };
    }
    // (flake-utils.lib.eachDefaultSystem (system: {
      formatter = inputs.nixpkgs.legacyPackages."${system}".nixpkgs-fmt;
    }));
}
