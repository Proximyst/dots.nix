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
    programs.gamemode.enable = true;
    programs.steam = {
      enable = true;
      extraCompatPackages = with pkgs; [
        mangohud
        proton-ge-bin
      ];
    };
  };
}
