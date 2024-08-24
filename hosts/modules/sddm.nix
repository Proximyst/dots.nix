{ pkgs, config, lib, ... }:

let
  cfg = config.modules.sddm;
in
with lib;
{
  options.modules.sddm = {
    enable = mkEnableOption "sddm";
  };

  config = mkIf cfg.enable {
    services.displayManager.sddm = {
      enable = true;
      autoNumlock = true;
      package = pkgs.kdePackages.sddm;
    };
  };
}
