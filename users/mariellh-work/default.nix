{ pkgs, ... }:

{
  home = {
    stateVersion = "24.05";

    username = "mariellh";
    homeDirectory = "/Users/mariellh";

    packages = with pkgs; [
      nvim-pkg
    ];
  };
}
