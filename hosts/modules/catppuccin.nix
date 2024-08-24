{ pkgs, inputs, config, lib, ... }:

let
  cfg = config.modules.catppuccin;
in
with lib;
{
  imports = [
    inputs.catppuccin.nixosModules.catppuccin
  ];

  options.modules.catppuccin = {
    enable = pkgs.my.mkDisableOption "catppuccin";
    flavor = mkOption {
      description = "the flavor of catppuccin to use";
      default = "macchiato";
      type = types.str;
    };
  };

  config = mkIf cfg.enable {
    catppuccin = {
      flavor = cfg.flavor;
    };

    console.catppuccin = {
      enable = true;
      flavor = cfg.flavor;
    };

    environment.systemPackages = mkIf config.modules.sddm.enable (with pkgs; [
      catppuccin-cursors."${cfg.flavor}Dark"
      (catppuccin-sddm.override {
        flavor = cfg.flavor;
        font = "Iosevka";
        fontSize = "14";
      })
    ]);
    services.displayManager.sddm = mkIf config.modules.sddm.enable {
      theme = "catppuccin-${cfg.flavor}";
      settings = {
        Theme.CursorTheme = "catppuccin-${cfg.flavor}-dark-cursors";
      };
    };
    services.xserver.displayManager.setupCommands = mkIf config.modules.sddm.enable ''
      ${pkgs.xorg.xrdb}/bin/xrdb -merge ${pkgs.writeText "catppuccin-xresources" "Xcursor.theme: catppuccin-${cfg.flavor}-dark-cursors"}
      ${pkgs.xorg.xsetroot}/bin/xsetroot -cursor_name left_ptr
    '';
  };
}
