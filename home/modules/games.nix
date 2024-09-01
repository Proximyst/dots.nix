{ config, pkgs, lib, ... }:

let
  cfg = config.modules.games;
in
with lib;
{
  options.modules.games = {
    enable = mkEnableOption "games";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      lutris
    ];
  };
}
