{ config, pkgs, ... }:

{
  boot.kernelModules = [ "wl" "nvidia" "nvidia_modeset" "nvidia_uvm" "nvidia_drm" ];
  boot.kernelParams = [
    "nvidia.NVreg_PreserveVideoMemoryAllocations=1"
    "nvidia.NVreg_TemporaryFilePath=/var/tmp"
    "mem_sleep_default=deep"
    "nvidia_drm.modeset=1"
  ];

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    open = false;

    powerManagement = {
      enable = false;
      finegrained = false;
    };

    modesetting = {
      enable = true;
    };

    nvidiaSettings = true;
    #package = config.boot.kernelPackages.nvidiaPackages.stable;
  };
  
  hardware.graphics.enable = true;

  environment.systemPackages = with pkgs; [
    cudaPackages.cudatoolkit
  ];
}