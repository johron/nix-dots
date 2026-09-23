{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    #jetbrains.idea
    #jetbrains.rust-rover
    #jetbrains.rider
    vscode
    zed-editor
    gdb
    onefetch
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; 
    enableFishIntegration = true;
    nix-direnv.enable = true; 
  };
}