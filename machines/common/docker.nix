_:
{
  virtualisation.docker = {
    enable = true;
    # I only really need docker for development purposes.
    enableOnBoot = false;
    enableNvidia = true;
    autoPrune = {
      enable = true;
      dates = "weekly";
    };
  };
}
