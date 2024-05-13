{ config, ... }:

{
  programs.alacritty = {
    enable = true;
    catppuccin.enable = true;

    settings = {
      font = {
        normal.family = "Iosevka";
      };
    };
  };
}
