{ pkgs, ... }:

{
  services.nix-daemon.enable = true;

  users.users.mariellh = {
    home = "/Users/mariellh";
  };

  nix.package = pkgs.nixVersions.latest;
  nix.extraOptions = ''
    experimental-features = nix-command flakes
    auto-optimise-store = true
  '';

  system.stateVersion = 4;
}
