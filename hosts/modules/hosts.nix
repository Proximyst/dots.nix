{ config, lib, ... }:

let
cfg = config.modules.hosts;
in
with lib;
{
  options.modules.hosts = {
    media.enable = mkEnableOption "media.enable";
  };

  config = {
    networking.hosts = {
      "192.168.50.100" = mkIf cfg.media.enable [
        "jf.mardroemmar.dev"
        "qb.mardroemmar.dev"
        "auth.mardroemmar.dev"
      ];
    };
  };
}
