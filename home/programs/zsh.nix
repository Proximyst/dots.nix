{ config, pkgs, ... }:

{
  programs.zsh = {
    enable = true;
    history.size = 10000;
    syntaxHighlighting.enable = true;
    syntaxHighlighting.catppuccin.enable = true;
    oh-my-zsh.enable = true;
    oh-my-zsh.theme = "robbyrussell";
    oh-my-zsh.plugins = [ "git" "1password" ];

    shellAliases = {
      v = "nvim";
      q = "exit";
      ":q" = "exit";
      ":wq" = "exit";
    };
  };
}
