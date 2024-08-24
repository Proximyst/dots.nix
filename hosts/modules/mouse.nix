{ config, lib, pkgs, ... }:

let cfg = config.modules.mouse;
in
with lib;
{
  options.modules.mouse = {
    enable = mkEnableOption "mouse";
    acceleration.disable = pkgs.my.mkDisableOption "mouse.acceleration";
  };

  config = mkIf cfg.enable {
    services.libinput = {
      enable = true;
      mouse.accelProfile = mkIf cfg.acceleration.disable "flat";
    };
  };
}
