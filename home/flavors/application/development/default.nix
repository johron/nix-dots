{ pkgs, lib, ... }:
{
  imports = [

  ];

  home.packages = with pkgs; [
    jetbrains.idea
    jetbrains.rust-rover
    google-cloud-sdk
    ninja
    godot-mono
    gdb
    flatpak-xdg-utils
    vscode
    cargo
    rustc
    rustfmt
    rustPlatform.rustLibSrc
    rust-analyzer
    lua51Packages.lua
    google-cloud-sdk
  ];
}