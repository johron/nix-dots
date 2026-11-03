{ config, pkgs, lib, inputs, ... }:

{
  environment.systemPackages = with pkgs; [
    git
    wget
    curl
    unzip
  ];
  
  programs.fish.enable = true;

  services.xserver.xkb = {
    layout = "no";
    variant = "winkeys";
    options = "compose:rctrl";
  };

  console.keyMap = "no";

  time.timeZone = "Europe/Oslo";

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.extraLocaleSettings = {
    LC_ADDRESS = "nn_NO.UTF-8";
    LC_IDENTIFICATION = "nn_NO.UTF-8";
    LC_MEASUREMENT = "nn_NO.UTF-8";
    LC_MONETARY = "nn_NO.UTF-8";
    LC_NAME = "nn_NO.UTF-8";
    LC_NUMERIC = "nn_NO.UTF-8";
    LC_PAPER = "nn_NO.UTF-8";
    LC_TELEPHONE = "nn_NO.UTF-8";
    LC_TIME = "nn_NO.UTF-8";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "$HOME/nix-dots/";
  };

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; 
    enableFishIntegration = true;
    nix-direnv.enable = true; 
  };
}