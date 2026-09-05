{ config, pkgs, ... }:

{
  services.xserver.videoDrivers = [ "nvidia" ];

  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "nvidia_drm.modeset=1"
    "mem_sleep_default=deep"
  ];

  hardware.graphics.enable = true;

  hardware.nvidia = {
    open = true;

    modesetting.enable = true;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    nvidiaSettings = true;

    package = config.boot.kernelPackages.nvidiaPackages.stable;
  };

  boot.blacklistedKernelModules = [ "nouveau" ];
}