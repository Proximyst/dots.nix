{ config, pkgs, ... }:

{
  fonts.packages = with pkgs;
    [
      iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "Iosevka" "FiraCode" ];
      })
    ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka" "FiraCode" "Noto Emoji" ];
  };
}
