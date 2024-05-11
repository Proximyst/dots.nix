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
    monospace = [ "Iosevka" "FiraCode" "Noto Emoji" "Font Awesome 6 Free" ];
  };
  fonts.fontconfig.localConf = ''
    <match target="pattern">
      <test name="family" qual="any">
        <string>fixed</string>
      </test>
      <edit binding="strong" mode="prepend" name="family">
        <string>Iosevka</string>
      </edit>
      <edit binding="strong" mode="prepend" name="family">
        <string>FiraCode</string>
      </edit>
      <edit binding="strong" mode="prepend" name="family">
        <string>Noto Emoji</string>
      </edit>
      <edit binding="strong" mode="prepend" name="family">
        <string>Font Awesome 6 Free</string>
      </edit>
    </match>
  '';
}
