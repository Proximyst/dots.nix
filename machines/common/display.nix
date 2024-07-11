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
      settings = {
        Theme.CursorTheme = "catppuccin-macchiato-dark-cursors";
      };
    };
  };
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrandr}/bin/xrandr --output DP-0 --mode 3440x1440 --rate 144 --primary
    ${pkgs.xorg.xrdb}/bin/xrdb -merge ${./Xresources}
    ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr
  '';
  programs.dconf.enable = true;
}
