{ hyprland, catppuccin, pkgs, ... }:

{
  imports = [
    hyprland.homeManagerModules.default
    catppuccin.homeManagerModules.catppuccin
    ./programs
  ];

  catppuccin.flavour = "macchiato";

  programs.home-manager.enable = true;

  home = {
    username = "mariell";
    homeDirectory = "/home/mariell";
    keyboard.layout = "sv-latin1";
  };

  home.packages = with pkgs; [
    discord
    google-chrome
    make gcc
  ];

  home.stateVersion = "23.11";
}
