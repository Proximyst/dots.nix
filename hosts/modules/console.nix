{ config, lib, pkgs, ... }:

let
  cfg = config.modules.console;
in
with lib;
{
  options.modules.console = {
    zsh.enable = pkgs.my.mkDisableOption "zsh";
    font = mkOption {
      description = "the font to use for the TTY console";
      default = "Lat2-Terminus16";
      type = types.str;
    };
    keyMap = mkOption {
      description = "the key mapping to use for the TTY console";
      example = "us";
      default = "sv-latin1";
      type = types.str;
    };
  };

  config = {
    programs.zsh.enable = cfg.zsh.enable;
    users.defaultUserShell = mkIf cfg.zsh.enable pkgs.zsh;

    console = {
      inherit (cfg) font keyMap;
    };
  };
}
