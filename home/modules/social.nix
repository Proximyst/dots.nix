{ config, lib, pkgs, ... }:

let
  cfg = config.modules.social;
in
with lib;
{
  options.modules.social = {
    discord.enable = mkEnableOption "discord";
    zoom.enable = mkEnableOption "zoom";
  };

  config = {
    home.packages = with pkgs; mkMerge [
      (mkIf cfg.discord.enable [ discord ])
      (mkIf cfg.zoom.enable [ zoom-us ])
    ];

    # TODO: Set up Vencord with catppuccin
  };
}
