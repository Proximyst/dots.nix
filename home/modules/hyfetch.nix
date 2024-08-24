{ config, lib, ... }:

let
  cfg = config.modules.hyfetch;
in
with lib;
{
  options.modules.hyfetch = {
    enable = mkEnableOption "hyfetch";
  };

  config = mkIf cfg.enable {
    programs.hyfetch = {
      enable = true;
      settings = {
        preset = "lesbian";
        mode = "rgb";
        color_align = {
          mode = "horizontal";
        };
      };
    };
  };
}
