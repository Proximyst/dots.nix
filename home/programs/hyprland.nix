{ config, libs, pkgs, ... }:

{
  wayland.windowManager.hyprland = {
    enable = true;
    xwayland.enable = true;
    catppuccin.enable = true;

    settings = {
      "$mod" = "SUPER";
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
      bind = [
        "$mod,Return,exec,alacritty"
        "$mod,D,exec,wofi"
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
      ];
      bindm = [
        "$mod,mouse:272,movewindow" # RMB
        "$mod,mouse:273,resizewindow" # RMB
      ];
      windowrulev2 = [
        "opacity 0.9,focus:0"
        "opacity 0.97,class:^(Alacritty)$,focus:1"
      ];
    };
  };

  services.hyprpaper = {
    enable = true;
    settings = {
      splash = false; # wtf?
      preload = [
        "${./anime-girl-katana.jpg}"
      ];
      wallpaper = [
        ",${./anime-girl-katana.jpg}"
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
        height = 14;
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
}
