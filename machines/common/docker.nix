_:
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

  hardware.nvidia-container-toolkit.enable = true;
}
