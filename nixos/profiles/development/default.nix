{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    vscode
    gdb
    onefetch
    graphite-cli
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; 
    enableFishIntegration = true;
    nix-direnv.enable = true; 
  };
}