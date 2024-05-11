{ catppuccin, pkgs, ... }:

{
  imports = [
    ./programs
    ./dev
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
    _1password
  ];

  home.stateVersion = "23.11";
}
