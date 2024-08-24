{ config, lib, pkgs, ... }:

let
  cfg = config.modules.devshells;
in
with lib;
{
  options.modules.devshells = {
    enable = mkEnableOption "devshells";
  };

  config = mkIf cfg.enable {
    nix.registry.devshells = {
      from = {
        id = "sh";
        type = "indirect";
      };
      to = {
        type = "path";
        path = builtins.toString ./devshells;
      };
    };
  };
}
