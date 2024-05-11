{ config, ... }:

{
  xdg.userDirs = {
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

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "text/html" = [ "firefox.desktop" ];
      "image/png" = [ "firefox.desktop" ];
      "image/jpeg" = [ "firefox.desktop" ];
      "text/plain" = [ "neovim.desktop" ];
    };
  };
}
