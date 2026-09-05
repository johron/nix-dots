{ pkgs, lib, ... }:
{
  home = {
    packages = with pkgs; [
      mako
      libnotify
    ];

    file = {
      mako = {
        target = ".config/mako/config";
        text = ''
          default-timeout=5000
        '';
      };
    };
  };
}