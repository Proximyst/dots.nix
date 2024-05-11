{ catppuccin, pkgs, ... }:

{
  imports = [
    ./programs
    ./xdg.nix
    ./cursor.nix
  ];

  catppuccin.flavour = "macchiato";

  home = {
    username = "mariell";
    homeDirectory = "/home/mariell";
    keyboard.layout = "sv-latin1";
  };

  home.packages = with pkgs; [
    spotify
    gnumake
    gcc
    htop
    ripgrep
  ];

  home.stateVersion = "23.11";
}
