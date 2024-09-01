{ username, pkgs, ... }:

{
  imports = [
    ./modules
  ];

  modules = {
    alacritty.enable = true;
    catppuccin.enable = true;
    catppuccin.flavor = "macchiato";
    direnv.enable = true;
    firefox.enable = true;
    games.enable = true;
    git = {
      enable = true;
      name = "Mariell Hoversholm";
      email = "mariell@mardroemmar.dev";
      signingKey = "~/.ssh/id_ed25519.pub";
    };
    hyfetch.enable = true;
    idea.enable = true;
    nvim.enable = true;
    social.discord.enable = true;
    wm.enable = true;
    wm.power.enable = true;
    xdg.userDirs.enable = true;
    xdg.mimeApps.enable = true;
    zsh.enable = true;
    zsh.zoxide.enable = true;
  };

  home = {
    stateVersion = "24.05";

    inherit username;

    packages = with pkgs; [
      spotify
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
      file

      # Games
      prismlauncher

      # Rust toolchain
      # TODO: Move to a devshell
      (fenix.complete.withComponents [
        "cargo"
        "clippy"
        "rust-src"
        "rustc"
        "rustfmt"
      ])
    ];
  };
}
