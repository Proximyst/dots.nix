{ config, pkgs, ... }:

{
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  hardware.graphics = {
    enable = true;
    extraPackages = with pkgs;
      [
        vaapiVdpau
        libvdpau-va-gl
      ];
    extraPackages32 = with pkgs.pkgsi686Linux;
      [
        libva
      ];
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    # powerManagement.enable = true;
    # powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    # forceFullCompositionPipeline = true;
  };

  environment.systemPackages = with pkgs;
    [
      vulkan-validation-layers
      libva-utils
    ];
  environment.sessionVariables = {
    #    GBM_BACKEND = "nvidia-drm";
    #    NVD_BACKEND = "direct";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    #    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    #    LIBVA_DRIVER_NAME = "nvidia";
    #    XWAYLAND_NO_GLAMOR = "1";
  };
}
