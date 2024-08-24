{ pkgs, config, lib, ... }:

let
  cfg = config.modules.display;
in
with lib;
{
  options.modules.display = {
    enable = mkEnableOption "display";
    bspwm.enable = pkgs.my.mkDisableOption "bspwm";
    out = mkOption {
      description = "the output device";
      example = "DP-0";
      default = "DP-0";
      type = types.str;
    };
    width = mkOption {
      description = "the output device's width";
      example = 1280;
      default = 1280;
      type = types.int;
    };
    height = mkOption {
      description = "the output device's height";
      example = 720;
      default = 720;
      type = types.int;
    };
    rate = mkOption {
      description = "the output device's refresh rate";
      example = 60;
      default = 60;
      type = types.int;
    };
    nvidia.enable = mkEnableOption "nvidia";
  };

  config = mkIf cfg.enable {
    services.xserver = {
      enable = true;
      xkb = {
        layout = "se";
        variant = "";
      };

      windowManager.bspwm.enable = cfg.bspwm.enable;

      displayManager.setupCommands = ''
        ${pkgs.xorg.xrandr}/bin/xrandr --output ${cfg.out} --mode ${builtins.toString cfg.width}x${builtins.toString cfg.height} --rate ${builtins.toString cfg.rate} --primary
      '';
    };

    programs.dconf.enable = true;

    boot.kernelModules = mkIf cfg.nvidia.enable [ "nvidia" "nvidia_modeset" "nvidia_drm" ];
    hardware.graphics = mkIf cfg.nvidia.enable {
      enable = true;
      extraPackages = with pkgs; [ vaapiVdpau libvdpau-va-gl ];
      extraPackages32 = with pkgs.pkgsi686Linux; [ libva ];
    };
    services.xserver.videoDrivers = mkIf cfg.nvidia.enable [ "nvidia" ];
    hardware.nvidia = mkIf cfg.nvidia.enable {
      modesetting.enable = true;
      # powerManagement.finegrained = true;
      open = false;
      nvidiaSettings = true;
      package = config.boot.kernelPackages.nvidiaPackages.beta;
      # forceFullCompositionPipeline = true;
    };

    environment.systemPackages = mkIf cfg.nvidia.enable (with pkgs; [ vulkan-validation-layers libva-utils ]);
    environment.sessionVariables = mkIf cfg.nvidia.enable {
      _JAVA_AWT_WM_NONREPARENTING = "1";
    };
  };
}
