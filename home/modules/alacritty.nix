{ config, lib, ... }:

let
  cfg = config.modules.alacritty;
in
with lib;
{
  options.modules.alacritty = {
    enable = mkEnableOption "alacritty";
  };

  config = mkIf cfg.enable {
    programs.alacritty = {
      enable = true;
      settings = {
        font = {
          normal.family = "Iosevka";
          size = 12.50;
        };
      };
    };
  };
}
