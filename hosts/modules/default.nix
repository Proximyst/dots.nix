_:

{
  imports = [
    ./boot.nix
    ./catppuccin.nix
    ./console.nix
    ./display.nix
    ./docker.nix
    ./fonts.nix
    ./games.nix
    ./mouse.nix
    ./nix.nix
    ./nvim.nix
    ./power.nix
    ./root.nix
    ./sddm.nix
    ./user.nix
  ];

  time.timeZone = "Europe/Stockholm";
  i18n.defaultLocale = "en_GB.UTF-8";
  networking.networkmanager.enable = true;
  programs.git.enable = true;
  security.polkit.enable = true;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
    jack.enable = true;
  };
  environment.pathsToLink = [ "/share/zsh" ];

  system.stateVersion = "24.05";
}
