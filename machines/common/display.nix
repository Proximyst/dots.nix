{ pkgs, ... }:
{
  # Remove mouse acceleration...
  services.libinput.enable = true;
  services.libinput.mouse.accelProfile = "flat";
  services.xserver = {
    enable = true;

    xkb = {
      layout = "se";
      variant = "";
    };

    windowManager.bspwm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    catppuccin-cursors.macchiatoDark
    (catppuccin-sddm.override {
      flavor = "macchiato";
      font = "Iosevka";
      fontSize = "14";
    })
  ];
  services.displayManager = {
    defaultSession = "none+bspwm";
    sddm = {
      enable = true;
      autoNumlock = true;
      package = pkgs.kdePackages.sddm;
      theme = "catppuccin-macchiato";
    };
  };
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge ${./Xresources}
  '';
  programs.dconf.enable = true;
}
