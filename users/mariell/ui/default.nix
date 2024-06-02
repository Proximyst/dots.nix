{ config, pkgs, inputs, ... }:

# TODO: Split this function into multiple modules, one for each part of the puzzle.
{
  home.packages = with pkgs; [
    # Screenshotting
    grim
    slurp
    # App menu
    j4-dmenu-desktop
    bemenu
  ];

  wayland.windowManager.hyprland = {
    enable = true;
    package = inputs.hyprland.packages.${pkgs.system}.hyprland;
    xwayland.enable = true;
    catppuccin.enable = true;

    settings = {
      input = {
        kb_layout = "se";
        sensitivity = "-0.3";
        accel_profile = "flat";
      };
      monitor = [
        "DP-1,3440x1440@144Hz,0x0,1"
      ];
      animation = [
        "windows,1,2,default"
        "fade,1,2,default"
        "workspaces,1,2,default"
      ];

      "$mod" = "SUPER";
      bind = [
        "$mod,Return,exec,alacritty"
        # TODO: Migrate the bemenu script to a proper shell bin script?
        "$mod,D,exec,j4-dmenu-desktop --dmenu='bemenu -i --center --list 10down --width-factor 0.2 -p apps -P \">\" --fb \"##24273a\" --ff \"##cad3f5\" --nb \"##24273a\" --nf \"##cad3f5\" --tb \"##24273a\" --hb \"##24273a\" --tf \"##ed8796\" --hf \"##eed49f\" --af \"##cad3f5\" --ab \"##24273a\"'"
        "$mod,Q,killactive"
        "$mod,H,movefocus,l"
        "$mod,L,movefocus,r"
        "$mod,K,movefocus,u"
        "$mod,J,movefocus,d"
        "SHIFT_$mod,H,movewindow,l"
        "SHIFT_$mod,L,movewindow,r"
        "SHIFT_$mod,K,movewindow,u"
        "SHIFT_$mod,J,movewindow,d"
        "ALT,TAB,focuscurrentorlast"
        "$mod,F,fullscreen"
        "$mod,G,fullscreen,1"
        "$mod,S,togglefloating"
        "$mod,1,focusworkspaceoncurrentmonitor,1"
        "$mod,2,focusworkspaceoncurrentmonitor,2"
        "$mod,3,focusworkspaceoncurrentmonitor,3"
        "$mod,4,focusworkspaceoncurrentmonitor,4"
        "$mod,5,focusworkspaceoncurrentmonitor,5"
        "SHIFT_$mod,1,movetoworkspace,1"
        "SHIFT_$mod,2,movetoworkspace,2"
        "SHIFT_$mod,3,movetoworkspace,3"
        "SHIFT_$mod,4,movetoworkspace,4"
        "SHIFT_$mod,5,movetoworkspace,5"
        "$mod,B,exec,firefox"
        "SHIFT_$mod,S,exec,grim -g \"$(slurp)\" - | wl-copy"
      ];
      bindm = [
        "$mod,mouse:272,movewindow" # RMB
        "$mod,mouse:273,resizewindow" # RMB
      ];

      windowrulev2 = [
        "opacity 1,fullscreen:1"
        "opacity 1,title:^(firefox)$"
        "opacity 0.9,focus:0"
        "opacity 0.9,workspace 2,class:^(Spotify)$"
        "opacity 0.97,class:^(Alacritty)$,focus:1"
      ];
      layerrule = [
        "noanim,menu"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;

    settings = {
      splash = false; # wtf?
      preload = [
        "${./../../../wallpapers/anime-girl-katana.jpg}"
      ];
      wallpaper = [
        ",${./../../../wallpapers/anime-girl-katana.jpg}"
      ];
    };
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
    catppuccin.enable = true;

    settings = {
      mainBar = {
        output = [ "DP-1" ];
        layer = "top";
        position = "top";
        height = 8;
        spacing = 6;
        modules-left = [ "hyprland/workspaces" ];
        modules-center = [ "hyprland/window" ];
        modules-right = [ "tray" "wireplumber" "clock" ];

        "hyprland/workspaces" = {
          persistent-workspaces."*" = 5;
        };
        tray = {
          spacing = 10;
          icon-size = 15;
          show-passive-items = true;
        };
        wireplumber = {
          tooltip = false;
          format = "🎧 {volume}%";
        };
        clock = {
          interval = 10;
          format = "🕙 {:%a %d %b %R}";
          tooltip = false;
        };
      };
    };
    style = builtins.readFile ./waybar.css;
  };

  home.pointerCursor = {
    name = "Catppuccin-Macchiato-Dark-Cursors";
    package = pkgs.catppuccin-cursors.macchiatoDark;
    gtk.enable = true;
  };
}
