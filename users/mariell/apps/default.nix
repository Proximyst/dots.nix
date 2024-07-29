{ pkgs, ... }:

{
  imports = [
    ./alacritty.nix
    ./direnv.nix
    ./dunst.nix
    ./firefox.nix
    ./git.nix
    ./hyfetch.nix
    ./intellij.nix
    ./social.nix
    ./zsh.nix
  ];

  home.packages = with pkgs; [
    _1password

    # Nicer CLI tools
    ripgrep
    fd
    jq
    dogdns
    htop
    sd

    # Basically necessities
    gnumake
    unzip

    # Games
    prismlauncher

    # Rust toolchain
    (fenix.complete.withComponents [
      "cargo"
      "clippy"
      "rust-src"
      "rustc"
      "rustfmt"
    ])

    nvim-pkg
  ];
}
