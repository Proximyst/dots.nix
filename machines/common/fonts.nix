{ pkgs, ... }:

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
        fonts = [ "Iosevka" "FiraCode" "NerdFontsSymbolsOnly" ];
      })
    ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka" "FiraCode" "Noto Emoji" "Font Awesome 6 Free" ];
  };
}
