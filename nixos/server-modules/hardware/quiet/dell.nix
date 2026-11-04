{ config, pkgs, ... }:

{
  boot.kernelModules = [ "dell-smm-hwmon" ];
  boot.extraModprobeConfig = "options dell-smm-hwmon ignore_dmi=1 restricted=0";
}