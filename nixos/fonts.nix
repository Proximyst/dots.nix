{ config, pkgs, ... }:

{
  fonts.packages = with pkgs;
    [
      iosevka
      fira-code
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      font-awesome
      (nerdfonts.override {
        fonts = [ "Iosevka" "FiraCode" ];
      })
    ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka" "FiraCode" "Noto Emoji" ];
  };
}
