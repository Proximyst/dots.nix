{ pkgs, lib, ... }:

let
  catppuccin-sddm = { pkgs }: pkgs.stdenv.mkDerivation {
    name = "catppuccin-sddm";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "sddm";
      rev = "main";
      hash = "sha256-TMElu+90/qtk4ipwfoALt7vKxxB9wxW81ZVbTfZI4kA=";
    };
    buildInputs = with pkgs; [ just gnused ];
    buildPhase = ''
      just build
    '';
    installPhase = ''
      mkdir -p $out
      cp -r ./dist/catppuccin-macchiato/* $out/
    '';
  };
in
{
  programs.hyprland.enable = true; # we need some stuff set up.

  services.displayManager = {
    enable = true;

    sddm = {
      enable = true;
      autoNumlock = true;
      wayland.enable = true;
      package = pkgs.kdePackages.sddm;
      theme = "${catppuccin-sddm { inherit pkgs; }}";
      extraPackages = with pkgs; [
        kdePackages.breeze-icons
        kdePackages.plasma5support
        kdePackages.qtsvg
        kdePackages.qtvirtualkeyboard
      ];
    };
  };
}
