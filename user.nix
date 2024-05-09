{ config, pkgs, ... }:

let
  home-manager = fetchTarball "https://github.com/nix-community/home-manager/archive/master.tar.gz";
  catppuccin = fetchTarball "https://github.com/catppuccin/nix/archive/main.tar.gz";
in
{
  imports =
    [
      (import "${home-manager}/nixos")
      (import "${catppuccin}/modules/nixos")
    ];

  programs.zsh.enable = true;
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

  fonts.packages = with pkgs;
    [
      iosevka
      noto-fonts
      noto-fonts-cjk
      noto-fonts-emoji
      (nerdfonts.override {
        fonts = [ "Iosevka" "FiraCode" ];
      })
    ];
  fonts.fontconfig.defaultFonts = {
    monospace = [ "Iosevka" "FiraCode" "Noto Emoji" ];
  };

  security.polkit.enable = true;
  home-manager.users.mariell = {
    imports =
      [
        (import "${catppuccin}/modules/home-manager")
      ];

    catppuccin.flavour = "macchiato";

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
      viAlias = true;
      vimAlias = true;
    };

    programs.zsh = {
      enable = true;
      history.size = 10000;
      syntaxHighlighting.enable = true;
      syntaxHighlighting.catppuccin.enable = true;
      oh-my-zsh.enable = true;
      oh-my-zsh.theme = "robbyrussell";
      oh-my-zsh.plugins = [ "git" ];

      shellAliases = {
        v = "nvim";
      };
    };

    home.keyboard.layout = "sv-latin1";

    programs.alacritty = {
      enable = true;
      catppuccin.enable = true;
      settings = {
        font = {
          normal.family = "Iosevka";
        };
      };
    };

    home.packages = with pkgs;
      [
        vulkan-validation-layers
        discord
        google-chrome
      ];
    wayland.windowManager.sway = {
      enable = true;
      catppuccin.enable = true;
      config = rec {
        modifier = "Mod4";
        terminal = "alacritty";
        input = {
          "type:keyboard" = {
            xkb_layout = "se";
            xkb_numlock = "enabled";
          };
          "type:pointer" = {
            pointer_accel = "-0.7";
          };
        };
        output = {
          DP-1 = {
            bg = "${./anime-girl-witch.jpg} fill";
            mode = "3440x1440@144Hz";
          };
        };
        fonts = {
          names = [ "Iosevka" "Noto Emojis" ];
          style = "Regular";
          size = 10.0;
        };
        colors = {
          background = "$base";
          focused = {
            background = "$base";
            border = "$lavender";
            childBorder = "$lavender";
            indicator = "$rosewater";
            text = "$text";
          };
          focusedInactive = {
            background = "$base";
            border = "$lavender";
            childBorder = "$lavender";
            indicator = "$rosewater";
            text = "$text";
          };
          unfocused = {
            background = "$base";
            border = "$lavender";
            childBorder = "$lavender";
            indicator = "$rosewater";
            text = "$text";
          };
          placeholder = {
            background = "$base";
            border = "$lavender";
            childBorder = "$lavender";
            indicator = "$rosewater";
            text = "$text";
          };
          urgent = {
            background = "$base";
            border = "$lavender";
            childBorder = "$lavender";
            indicator = "$overlay0";
            text = "$peach";
          };
        };
        bars = [{
          fonts = {
            names = [ "Iosevka" "Noto Emojis" ];
            style = "Regular";
            size = 10.0;
          };
          colors = {
            background = "$base";
            bindingMode = {
              background = "$base";
              border = "$base";
              text = "$text";
            };
            focusedBackground = "$base";
            focusedSeparator = "$base";
            focusedWorkspace = {
              background = "$base";
              border = "$base";
              text = "$text";
            };
            inactiveWorkspace = {
              background = "$base";
              border = "$base";
              text = "$surface1";
            };
            separator = "$base";
            statusline = "$text";
            urgentWorkspace = {
              background = "$base";
              border = "$base";
              text = "$red";
            };
          };
        }];
      };
      extraOptions =
        [
          "--unsupported-gpu"
          #"--my-next-gpu-wont-be-nvidia"
        ];
    };

    # This should never change. Ever.
    home.stateVersion = "23.11";
  };

  # Important packages for all users.
  environment.systemPackages = with pkgs;
    [
      curl
      wget
    ];
}
