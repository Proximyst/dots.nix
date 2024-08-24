_:

{
  imports = [
    ./hardware-configuration.nix
  ];

  modules = {
    fonts.enable = true;
    sddm.enable = true;
    docker.enable = true;
    games.enable = true;
    devshells.enable = true;

    display = {
      enable = true;
      out = "DP-0";
      width = 3440;
      height = 1440;
      rate = 144;
      nvidia.enable = true;
    };

    user = {
      name = "mariell";
      home = "/home/mariell";
      extraGroups = [ "wheel" ];
    };
  };
}
