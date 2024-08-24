{ pkgs, config, lib, ... }:

let
  cfg = config.modules.boot;
in
with lib;
{
  options.modules.boot = {
    systemd-boot.enable = pkgs.my.mkDisableOption "systemd-boot";
    efi.enable = pkgs.my.mkDisableOption "efi";
    efi.mount = mkOption {
      description = "where is the boot dir mounted to in the hardware config?";
      default = "/boot";
      type = types.str;
    };
  };

  config = {
    boot.loader = {
      systemd-boot.enable = cfg.systemd-boot.enable;
      efi = mkIf cfg.efi.enable {
        canTouchEfiVariables = true;
        efiSysMountPoint = cfg.efi.mount;
      };
    };
  };
}
