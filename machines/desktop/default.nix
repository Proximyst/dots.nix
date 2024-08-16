{ inputs, ... } @ inArgs:

{
  imports = [
    # Required, basic modules. Without these, the system will not be usable to any extent.
    ./hardware.nix
    ./nvidia.nix

    # Per-machine config
    ./boot.nix

    # User config
    (import ../../users/mariell inArgs)
  ];

  time.timeZone = "Europe/Stockholm";

  networking.hostName = "mariell-nix";
  networking.networkmanager.enable = true;

  programs.git.enable = true;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
  };

  security.polkit.enable = true;

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
