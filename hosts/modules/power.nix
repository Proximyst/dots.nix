{ config, lib, ... }:

let
  cfg = config.modules.power;
in
with lib;
{
  options.modules.power = {
    enable = mkEnableOption "power";
  };

  config = mkIf cfg.enable {
    powerManagement.enable = true;
    hardware.nvidia.powerManagement.enable = config.modules.display.nvidia.enable;
  };
}
