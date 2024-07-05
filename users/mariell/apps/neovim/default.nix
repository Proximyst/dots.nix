{ config, pkgs, neovim-nightly-overlay, ... }:

{
  programs.neovim = {
    enable = true;
    defaultEditor = true;
    viAlias = true;
    vimAlias = true;
    #package = pkgs.neovim-nightly;
    package = neovim-nightly-overlay.packages.${pkgs.system}.default;
    extraPackages = with pkgs; [
      # LSP pre-reqs
      python3
      nodejs_22
      # LSPs
      lua-language-server
      rust-analyzer-nightly
      # jsonls
      vscode-langservers-extracted
      nodePackages.bash-language-server
      clang
      dockerfile-language-server-nodejs
      pyright
      python311Packages.jedi-language-server
      taplo
      gopls
      elixir-ls

      # Plugin pre-reqs
      fzf
    ];
  };

  xdg.configFile = {
    "nvim/init.lua".source = ./init.lua;
    "nvim/lua".source = ./lua;
  };
}
