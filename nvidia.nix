{ config, pkgs, ... }:

{
  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs;
      [
        # nvidia-vaapi-driver
        vaapiVdpau
      ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.stable;
    forceFullCompositionPipeline = true;
  };

  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
  };
}
