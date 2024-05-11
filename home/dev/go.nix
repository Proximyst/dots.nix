{ config, pkgs, ... }:

{
  programs.go = {
    enable = true;
    goBin = "./local/bin-go";
    goPath = "./local/path-go";
  };
}
