{ config, pkgs, ... }:

{
  services.dunst = {
    enable = true;
    catppuccin.enable = true;
    iconTheme = {
      package = pkgs.gnome.adwaita-icon-theme;
      name = "Adwaita";
    };
    settings = {
      global = {
        width = 400;
        height = 256;
        offset = "30x50";
        origin = "top-right";
        transparency = 10;
        font = "Iosevka Nerd Font Mono";
      };
    };
  };
}
