{ pkgs, lib, inputs, ... }:

let
  catppuccin-sddm = { pkgs }: pkgs.stdenv.mkDerivation {
    name = "catppuccin-sddm";
    src = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "sddm";
      rev = "main";
      hash = "sha256-sIqyTESrtNITrD1eBpqycMrVa/sXa0BO4AzDoXyPGSA=";
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
  # Remove mouse acceleration...
  services.libinput.enable = true;
  services.libinput.mouse.accelProfile = "flat";
  services.xserver = {
    enable = true;

    xkb = {
      layout = "se";
      variant = "";
    };

    #    xrandrHeads = [ "DP-1" ];
    #    resolutions = [
    #      {
    #        x = 3440;
    #        y = 1440;
    #      }
    #    ];

    windowManager.bspwm.enable = true;
  };

  environment.systemPackages = with pkgs; [
    catppuccin-cursors.macchiatoDark
  ];
  services.displayManager = {
    defaultSession = "none+bspwm";
    sddm = {
      enable = true;
      autoNumlock = true;
      package = pkgs.kdePackages.sddm;
      theme = "${catppuccin-sddm { inherit pkgs; }}";
    };
  };
  services.xserver.displayManager.setupCommands = ''
    ${pkgs.xorg.xrdb}/bin/xrdb -merge ${./Xresources}
  '';
  programs.dconf.enable = true;
}
