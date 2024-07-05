{ config, pkgs, ... }:

{
  virtualisation.docker = {
    enable = true;
    # I only really need docker for development purposes.
    enableOnBoot = false;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
