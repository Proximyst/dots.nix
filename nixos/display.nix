{ pkgs, ... }:

{
  programs.hyprland.enable = true; # we need some stuff set up.

  services.displayManager = {
    enable = true;

    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
    };
  };
}
