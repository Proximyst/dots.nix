{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
    zoom-us
  ];

  # TODO: Set up Vencord with catppuccin
}
