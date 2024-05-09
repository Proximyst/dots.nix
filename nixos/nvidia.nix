{ config, pkgs, ... }:

{
  boot.kernelModules = [ "nvidia" "nvidia_modeset" "nvidia_drm" ];

  hardware.opengl = {
    enable = true;
    driSupport = true;
    driSupport32Bit = true;
    extraPackages = with pkgs;
      [
        vaapiVdpau
        libvdpau-va-gl
      ];
    extraPackages32 = with pkgs.pkgsi686Linux;
      [
        libva
      ];
    setLdLibraryPath = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    modesetting.enable = true;
    # powerManagement.enable = true;
    # powerManagement.finegrained = true;
    open = false;
    nvidiaSettings = true;
    package = config.boot.kernelPackages.nvidiaPackages.beta;
    forceFullCompositionPipeline = true;
  };

  environment.systemPackages = with pkgs;
    [
      vulkan-validation-layers
      libva-utils
    ];
  environment.sessionVariables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    WLR_RENDERER = "vulkan";
    NIXOS_OZONE_WL = "1";
    GBM_BACKEND = "nvidia-drm";
    NVD_BACKEND = "direct";
    MOZ_ENABLE_WAYLAND = "1";
    _JAVA_AWT_WM_NONREPARENTING = "1";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
    LIBVA_DRIVER_NAME = "nvidia";
    XWAYLAND_NO_GLAMOR = "1";
  };
}
