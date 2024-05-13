# This file is called from the system-level configuration, not home-manager.
# The intent is to set up home-manager here.

{ inputs }:

{ config, pkgs, ... }:

let
  sys-conf = import ./config.nix;
in
{
  imports = [
    ./games.nix
  ];

  users.users."${sys-conf.currentUser}" = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users."${sys-conf.currentUser}" =
    {
      imports = [
        # From flake
        inputs.catppuccin.homeManagerModules.catppuccin
        inputs.walker.homeManagerModules.walker

        # From config
        ./ui
        ./xdg.nix
        ./apps
      ];

  catppuccin.flavour = "macchiato";

      home = {
        # Use the same version as we use for NixOS.
        stateVersion = "23.11"; # don't touch!

        username = sys-conf.currentUser;
        homeDirectory = "/home/${sys-conf.currentUser}";
      };
    };
}