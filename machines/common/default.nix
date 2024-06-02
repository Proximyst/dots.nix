{ inputs }:

{ config
, pkgs
, lib
, ...
}:

{
  imports = [
    ./fonts.nix
    ./display.nix
    (import ./overlays.nix { inherit inputs; })
  ];

  programs.zsh.enable = true;
  users = {
    defaultUserShell = pkgs.zsh;
    mutableUsers = true; # allow using `passwd` on users

    users.root = {
      home = "/root";
      uid = 0;
      group = "root";
      initialHashedPassword = lib.mkDefault ""; # allow password-less login
    };
  };

  nixpkgs.config.allowUnfree = true;
  nix =
    let
      flakeInputs = lib.filterAttrs (name: value: (value ? outputs) && (name != "self")) inputs;
    in
    {
      # Enable flakes.
      settings.experimental-features = [ "nix-command" "flakes" ];

      # Clean up unused revisions & packages.
      gc = {
        automatic = true;
        dates = "weekly";
        options = "--delete-older-than 14d";
      };
      # Replace duplicates in /nix/store with hard-links.
      optimise = {
        automatic = true;
        dates = [ "17:55" ];
      };
      settings.auto-optimise-store = true;
      # Use as many cores as possible.
      settings.build-cores = 8;
      settings.max-jobs = "auto";
      # Run nix jobs in a sandbox
      settings.sandbox = true;

      registry = builtins.mapAttrs (name: v: { flake = v; }) flakeInputs;
    };

  programs.neovim = {
    enable = true;
    defaultEditor = true;
    vimAlias = true;
    viAlias = true;
  };

  i18n.defaultLocale = "en_GB.UTF-8";

  networking.firewall.enable = true;

  # This option defines the first version of NixOS you have installed on this particular machine,
  # and is used to maintain compatibility with application data (e.g. databases) created on older NixOS versions.
  #
  # Most users should NEVER change this value after the initial install, for any reason,
  # even if you've upgraded your system to a new NixOS release.
  #
  # This value does NOT affect the Nixpkgs version your packages and OS are pulled from,
  # so changing it will NOT upgrade your system.
  #
  # This value being lower than the current NixOS release does NOT mean your system is
  # out of date, out of support, or vulnerable.
  #
  # Do NOT change this value unless you have manually inspected all the changes it would make to your configuration,
  # and migrated your data accordingly.
  #
  # For more information, see `man configuration.nix` or https://nixos.org/manual/nixos/stable/options#opt-system.stateVersion .
  system.stateVersion = "24.05"; # Did you read the comment?
}
