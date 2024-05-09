{ config, pkgs, ... }:

let
  home-manager = fetchTarball "https://github.com/nix-community/home-manager/archive/release-23.11.tar.gz";
in
{
  imports =
    [ (import "${home-manager}/nixos")
    ];

  programs.zsh.enable = true;
  programs.zsh.syntaxHighlighting.enable = true;
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.theme = "robbyrussell";
  programs.zsh.ohMyZsh.plugins = [ "git" ];
  programs.git.enable = true;

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  users.defaultUserShell = pkgs.zsh;
  users.users.mariell = {
    isNormalUser = true;
    extraGroups = [ "wheel" ];
  };

  home-manager.users.mariell = {
    programs.git = {
      enable = true;
      lfs.enable = true;
      userName = "Mariell Hoversholm";
      userEmail = "mariell@mardroemmar.dev";
      delta.enable = true;
      delta.options = {
        navigate = true;
	light = false;
	line-numbers = true;
	side-by-side = true;
	syntax-theme = "gruvbox-dark";
      };
      extraConfig = {
        init.defaultBranch = "main";
	pull.rebase = true;
	diff.colormoved = "zebra";
	diff.algorithm = "histogram";
	blame.pager = "delta";
	merge.conflictstyle = "diff3";
	checkout.workers = 0;
	pack.writeReverseIndex = true;
	gpg.format = "ssh";
	feature.manyFiles = true;
	lfs.locksverify = false;
      };
    };

    programs.neovim = {
      enable = true;
      defaultEditor = true;
      package = pkgs.unstable.neovim-unwrapped;
      viAlias = true;
      vimAlias = true;
    };

    # This should never change. Ever.
    home.stateVersion = "23.11";
  };

  # Important packages for all users.
  environment.systemPackages = with pkgs;
    [ curl wget
    ];
}
