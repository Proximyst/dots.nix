{ catppuccin, pkgs, ... }:

{
  imports = [
    ./programs
  ];

  catppuccin.flavour = "macchiato";

  home = {
    username = "mariell";
    homeDirectory = "/home/mariell";
    keyboard.layout = "sv-latin1";
  };

  home.packages = with pkgs; [
    discord
    google-chrome
    gnumake
    gcc
  ];

  home.stateVersion = "23.11";
}
