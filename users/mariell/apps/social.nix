{ config, pkgs, ... }:

{
  home.packages = with pkgs; [
    discord
  ];

  # TODO: Set up Vencord with catppuccin
}
