{ config, pkgs, ... }:

{
  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    gtk.enable = true;
  };
}
