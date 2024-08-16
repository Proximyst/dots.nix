# This file is called from the system-level configuration, not home-manager.
# The intent is to set up home-manager here.

{ inputs, user, ... }:

{
  imports = [
    ./games.nix
  ];

  users.users.${user} = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.${user} =
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

        username = user;
        homeDirectory = "/home/${user}";
      };
    };
}
