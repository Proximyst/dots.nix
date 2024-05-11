{ config, pkgs, ... }:

{
  programs.walker = {
    enable = true;
    runAsService = true;

    config = {
      fullscreen = false;
      list.height = 750;
      modules = [
        {
          name = "applications";
        }
      ];
    };
  };
}
