{ pkgs, lib, ... }:
{
  environment.systemPackages = with pkgs; [
    jetbrains.idea
    jetbrains.rust-rover
    jetbrains.rider
    vscode
    gdb
    onefetch
  ];

  programs.direnv = {
    enable = true;
    enableBashIntegration = true; 
    nix-direnv.enable = true; 
  };
}