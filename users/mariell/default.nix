# This file is called from the system-level configuration, not home-manager.
# The intent is to set up home-manager here.

{ inputs, ... }:

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

        # From config
        ./ui
        ./xdg.nix
        ./apps
      ];

      catppuccin.flavor = "macchiato";

      home = {
        # Use the same version as we use for NixOS.
        stateVersion = "24.05"; # don't touch!

        username = sys-conf.currentUser;
        homeDirectory = "/home/${sys-conf.currentUser}";
      };
    };
}
