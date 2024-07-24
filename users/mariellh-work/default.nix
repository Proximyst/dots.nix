{ pkgs, inputs, ... }:

{
imports = [
        inputs.catppuccin.homeManagerModules.catppuccin
../mariell/apps/zsh.nix
];

  home = {
    stateVersion = "24.05";

    username = "mariellh";
    homeDirectory = "/Users/mariellh";

    packages = with pkgs; [
      nvim-pkg
    ];
  };
}
