{ config, pkgs, lib, ... }:

let
  cfg = config.modules.docker;
in
with lib;
{
  options.modules.docker = {
    enable = mkEnableOption "docker";
    onBoot = mkEnableOption "on-boot";
  };

  config = mkIf cfg.enable {
    virtualisation.docker = {
      enable = true;
      enableOnBoot = cfg.onBoot;
      autoPrune = {
        enable = true;
        dates = "weekly";
      };
    };

    hardware.nvidia-container-toolkit.enable = config.modules.display.nvidia.enable;
  };
}
