{ config, pkgs, lib, ... }:

let
  cfg = config.modules.wm;
in
with lib;
{
  options.modules.wm = {
    enable = mkEnableOption "wm";
    power.enable = mkEnableOption "wm.power";
  };

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      # To set wallpaper
      hsetroot
      # For clipboard access
      xclip
      # For screenshots
      maim
      # For the external rules
      xdo
      xdotool
      # For xinput
      perl
      gnugrep
      xorg.xinput
    ];

    xsession.windowManager.bspwm =
      {
        enable = true;
        extraConfig = ''
          bspc monitor -d browser discord active spotify 5 6 7 8 9 10
          bspc config pointer_modifier mod4
          bspc config pointer_action1 move
          bspc config pointer_action2 resize_side
          bspc config pointer_action3 resize_corner
          bspc config automatic_scheme spiral
          bspc config ignore_ewmh_focus true
          bspc config external_rules_command "${./bspwm-external-rules.sh}"

          for id in "$(xinput list --short | grep 'pointer' | grep 'Logitech G Pro' | perl -ne 'while (m/id=(\d+)/g) { print "$1\n"; }')"; do
            xinput --set-prop "$id" 'libinput Accel Speed' -0.8
            xinput --set-prop "$id" 'libinput Middle Emulation Enabled' 0
          done
        '';

        # TODO: Inherit display cfg from host config
        startupPrograms = [
          "xrandr --output DP-0 --mode 3440x1440 --rate 144 --primary"
          "hsetroot -cover ${./../../../wallpapers/anime-girl-katana.jpg}"
          "xsetroot -cursor_name left_ptr"
          "polybar"
          "discord"
          "spotify"
          "firefox"
        ];

        rules = {
          # See also the external rules shell.
          "discord" = {
            desktop = "^2";
            follow = false;
            focus = false;
          };
          "firefox" = {
            desktop = "^1";
            follow = false;
            focus = false;
          };
        };
      };

    services.sxhkd = {
      enable = true;
      keybindings = {
        "super + Return" = "alacritty";
        "super + Escape" = "pkill --signal SIGUSR1 -x sxhkd";
        "super + b" = "firefox";
        "super + q" = "bspc node -c";
        "super + g" = "bspc node -s biggest.local";
        "super + shift + q" = "bspc node -k";
        "super + d" = "rofi -show drun";
        "super + shift + 4" = "maim -s | xclip -selection clipboard -t image/png";
        "super + shift + ctrl + l" = mkIf cfg.power.enable "systemctl suspend";
      };

      extraConfig = ''
        super + {_, ctrl +}{h,j,k,l}
          bspc node -{f,s} {west,south,north,east}

        super + {_, ctrl +}{1-9,10}
          bspc {desktop -f,node -d} '^{1-9,10}'

        super + {p,o,comma,period}
          bspc node -f @{parent,brother,first,second}

        super + {y,shift + y,s,f}
          bspc node -t {tiled,pseudo_tiled,floating,fullscreen}

        super + shift + f
          xdotool getwindowfocus windowsize 3440 1440 && xdotool getwindowfocus windowmove 0 0
      '';
      # TODO: Inherit display sz from host config
    };

    programs.rofi = {
      enable = true;
      extraConfig = {
        modi = "window,run,drun";
        lines = 16;
        padding = 30;
        width = 45;
        location = 0;
        columns = 3;
      };
    };

    services.polybar = {
      enable = true;
      package = pkgs.polybar.override {
        pulseSupport = true;
      };

      script = "polybar -r top &";

      settings = {
        "bar/top" = {
          width = "90%";
          height = "24";
          offset.x = "5%";
          offset.y = "8";

          background = "\${colors.base}";
          foreground = "\${colors.text}";

          line.size = "2";
          line.color = "\${colors.surface0}";

          border.size = "0";
          padding.left = "0";
          padding.right = "1";
          spacing = "0";
          module.margin.left = "0";
          module.margin.right = "2";
          font = [
            "Iosevka:pixelsize=11;0"
            "Noto Color Emoji:scale=7;0"
          ];

          wm.restack = "bspwm";
          cursor.click = "pointer";
          cursor.scroll = "ns-resize";

          modules = {
            left = "bspwm";
            center = "xwindow";
            right = "audio date";
          };
        };

        "module/xwindow" = {
          type = "internal/xwindow";
          label.maxlen = "120";
        };

        "module/bspwm" = {
          type = "internal/bspwm";

          label.focused = "%name%";
          label.focused-background = "\${colors.surface1}";
          label.focused-padding = "2";

          label.occupied = "%name%";
          label.occupied-padding = "2";

          label.urgent = "%name%!";
          label.urgent-background = "\${colors.maroon}";
          label.urgent-foreground = "\${colors.crust}";
          label.urgent-padding = "2";

          label.empty = "%name%";
          label.empty-padding = "2";
        };

        "module/date" = {
          type = "internal/date";
          interval = "5.0";

          date = "%a %b %e";
          date-alt = "%Y-%m-%d (wk. %V)";

          time = "%H:%M";

          label = "%date% %time%";
        };

        "module/audio" = {
          type = "internal/pulseaudio";

          format.volume-margin = "0";
          format.volume = "<ramp-volume> <label-volume>";
          label.volume.foreground = "\${colors.text}";

          ramp.volume = [ "🔈" "🔉" "🔊" ];
          label.muted = "🔇";
        };

        "settings" = {
          screenchange.reload = true;
          pseudo-transparency = true;
        };

        "global/wm" = {
          margin.top = "0";
          margin.bottom = "0";
        };
      };
    };

    services.dunst = {
      enable = true;
      iconTheme = {
        package = pkgs.adwaita-icon-theme;
        name = "Adwaita";
      };
      settings = {
        global = {
          width = 400;
          height = 256;
          offset = "30x50";
          origin = "top-right";
          transparency = 10;
          font = "Iosevka Nerd Font Mono";
        };
      };
    };
  };
}
