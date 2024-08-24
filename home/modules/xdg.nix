{ config, lib, ... }:

let
  cfg = config.modules.xdg;
in
with lib;
{
  options.modules.xdg = {
    userDirs.enable = mkEnableOption "xdg.userDirs";
    mimeApps.enable = mkEnableOption "xdg.mimeApps";
  };

  config = {
    xdg.userDirs = mkIf cfg.userDirs.enable {
      enable = true;
      createDirectories = false;

      download = "$HOME/downloads";
      desktop = "$HOME/desktop";
      documents = "$HOME/documents";
      publicShare = "$HOME/etc/public";
      templates = "$HOME/etc/templates";
      music = "$HOME/media/music";
      pictures = "$HOME/media/pictures";
      videos = "$HOME/media/videos";
    };

    xdg.mimeApps = mkIf cfg.mimeApps.enable {
      enable = true;
      defaultApplications = mkMerge [
        (mkIf config.modules.firefox.enable {
          "text/html" = [ "firefox.desktop" ];
          "image/png" = [ "firefox.desktop" ];
          "image/jpeg" = [ "firefox.desktop" ];
        })
        (mkIf config.modules.nvim.enable {
          "text/plain" = [ "neovim.desktop" ];
        })
      ];
    };
  };
}
