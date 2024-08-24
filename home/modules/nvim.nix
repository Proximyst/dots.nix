{ pkgs, config, lib, ... }:

let
  cfg = config.modules.nvim;
in
with lib;
{
  options.modules.nvim = {
    enable = mkEnableOption "nvim";
    package = mkPackageOption pkgs "nvim" {
      default = [ "nvim-pkg" ];
    };
  };

  config = mkIf cfg.enable {
    home.packages = [ cfg.package ];
  };
}
