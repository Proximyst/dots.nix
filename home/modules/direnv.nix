{ config, lib, ... }:

let
  cfg = config.modules.direnv;
in
with lib;
{
  options.modules.direnv = {
    enable = mkEnableOption "direnv";
  };

  config = mkIf cfg.enable {
    programs.direnv = {
      enable = true;
      nix-direnv.enable = true;

      enableZshIntegration = config.modules.zsh.enable;
    };
  };
}
