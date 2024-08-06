{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    extraCompatPackages = with pkgs; [
      mangohud
      proton-ge-bin
    ];
  };
}
