{ pkgs, ... }:
{
  programs.zsh.enable = true;
  users.defaultUserShell = pkgs.zsh;

  console = {
    font = "Lat2-Terminus16";
    keyMap = "sv-latin1";
  };
}
