{ config, lib, ... }:

let
  cfg = config.modules.nvim;
in
with lib;
{
  options.modules.nvim = {
    enable = mkEnableOption "nvim";
  };

  config = mkIf cfg.enable {
    programs.neovim = {
      enable = true;
      defaultEditor = true;
      vimAlias = true;
      viAlias = true;
    };
    environment.sessionVariables = {
      EDITOR = "nvim";
    };
  };
}
