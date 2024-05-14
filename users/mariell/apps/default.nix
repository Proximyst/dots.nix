{ config, pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./hyfetch.nix
    ./neovim
    ./social.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    spotify
    _1password

    # Nicer CLI tools
    ripgrep
    fd
    jq
    dogdns
    htop

    # Basically necessities
    gnumake
    unzip

    # Rust toolchain
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])
  ];
}
