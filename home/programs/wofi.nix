{ config, pkgs, ... }:

{
  programs.wofi = {
    enable = true;
    settings = {
      show = "drun";
      width = 750;
      height = 400;
      term = "alacritty";
      insensitive = true;
      columns = 2;
      prompt = "";
    };
    style = ''
      ${builtins.readFile "${pkgs.catppuccin.out}/waybar/macchiato.css"}
      ${builtins.readFile "${./wofi.css}"}
    '';
  };
}
