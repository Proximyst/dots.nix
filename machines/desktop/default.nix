# This file is called by the flake's `nixosConfigurations` setup.

{ config, pkgs, inputs, lib, ... }:

{
  imports = [
    # Required, basic modules. Without these, the system will not be usable to any extent.
    (import ../common { inherit inputs; })
    ./hardware.nix
    ./nvidia.nix

    # Per-machine config
    ./boot.nix

    # User config
    (import ../../users/mariell { inherit inputs; })
    inputs.catppuccin.nixosModules.catppuccin
  ];

  catppuccin.flavor = "macchiato";

  time.timeZone = "Europe/Stockholm";

  networking.hostName = "mariell-nix";
  networking.networkmanager.enable = true;

  programs.git.enable = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
    catppuccin.enable = true;
    catppuccin.flavor = "macchiato";
  };

  security.polkit.enable = true;

  sound.enable = false; # I use PipeWire
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };

  programs.zsh.enable = true;
  environment.pathsToLink = [ "/share/zsh" ];
}
