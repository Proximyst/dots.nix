{ pkgs, inputs, config, lib, ... }:

let
  cfg = config.modules.catppuccin;
in
with lib;
{
  imports = [
    inputs.catppuccin.homeManagerModules.catppuccin
  ];

  options.modules.catppuccin = {
    enable = pkgs.my.mkDisableOption "catppuccin";
    flavor = mkOption {
      description = "the flavor of catppuccin to use";
      default = "macchiato";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      flavor = cfg.flavor;
    };

    home.pointerCursor = {
      name = "catppuccin-${cfg.flavor}-dark-cursors";
      package = pkgs.catppuccin-cursors."${cfg.flavor}Dark";
      gtk.enable = true;
      x11.enable = true;
    };
    gtk.enable = true;

    programs.alacritty.catppuccin.enable = config.modules.alacritty.enable;
    programs.zsh.syntaxHighlighting.catppuccin.enable = config.modules.zsh.enable;
    services.polybar.catppuccin = mkIf config.modules.wm.enable {
      enable = true;
      flavor = cfg.flavor;
    };
    programs.rofi.catppuccin = mkIf config.modules.wm.enable {
      enable = true;
      flavor = cfg.flavor;
    };
    services.dunst.catppuccin.enable = config.modules.wm.enable;
  };
}
