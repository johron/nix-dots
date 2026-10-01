{ config, pkgs, ... }:

{
  services.logind = {
    powerKey = "suspend";
    powerKeyLongPress = "poweroff";
  };
}