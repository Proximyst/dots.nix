{ pkgs, inputs, ... }:

let
  flavor = "macchiato";
in
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

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
  services.displayManager.sddm = {
    theme = "catppuccin-sddm";
    settings = {
      Theme.CursorTheme = "catppuccin-macchiato-dark-cursors";
    };
  };
}
