{ inputs, ... }:
{ pkgs, ... }:

let flavor = "macchiato";
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

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

  catppuccin = {
    inherit flavor;
  };

  console.catppuccin = {
    enable = true;
    inherit flavor;
  };

  environment.systemPackages = with pkgs; [
    catppuccin-cursors.macchiatoDark
    (catppuccin-sddm.override {
      inherit flavor;
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
      theme = "catppuccin-sddm";
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
