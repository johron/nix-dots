{ config, pkgs, lib, inputs, host, ... }:

let
  hostname = host.hostname;
in 
{
  config = {
    home.file.".config/hypr/hyprland.lua".source = ./hypr/hyprland.lua;
    home.file.".config/hypr/modules/autostart.lua".source = ./hypr/modules/autostart.lua; 
    home.file.".config/hypr/modules/environment.lua".source = ./hypr/modules/environment.lua; 
    home.file.".config/hypr/modules/look_and_feel.lua".source = ./hypr/modules/look_and_feel.lua; 
    home.file.".config/hypr/modules/misc.lua".source = ./hypr/modules/misc.lua; 
    home.file.".config/hypr/modules/input.lua".source = ./hypr/modules/input.lua; 
    home.file.".config/hypr/modules/keybindings.lua".source = ./hypr/modules/keybindings.lua; 
    home.file.".config/hypr/modules/windows_and_workspaces.lua".source = ./hypr/modules/windows_and_workspaces.lua; 
    home.file.".config/hypr/modules/monitors.lua".source = (./. + "/../../../../hosts/${hostname}/home/modules/desktop/hyprland/hypr/modules/monitors.lua");
    home.file.".config/hypr/modules/shell.lua".source = (./. + "/../../../../hosts/${hostname}/home/modules/desktop/hyprland/hypr/modules/shell.lua");

    xdg = {
      userDirs = {
        enable = true;
        createDirectories = true;
        
        documents = "$HOME/Documents";
        download = "$HOME/Downloads";
        desktop = "$HOME/Desktop";
        music = "$HOME/Music";
        pictures = "$HOME/Pictures";
        videos = "$HOME/Videos";
        projects = "$HOME/Projects";
      };

      mimeApps = {
        enable = true;

        defaultApplications = {
          "inode/directory" = [ "org.kde.dolphin.desktop" ];

          "x-scheme-handler/http" = "firefox.desktop";
          "x-scheme-handler/https" = "firefox.desktop";
          "text/plain" = "code.desktop";
          "text/csv" = "code.desktop";
          "application/pdf" = "firefox.desktop";
          "image/jpeg" = "org.nomacs.ImageLounge.desktop";
          "image/png" = "org.nomacs.ImageLounge.desktop";
          "image/gif" = "org.nomacs.ImageLounge.desktop";
          "image/webp" = "org.nomacs.ImageLounge.desktop";
          "image/bmp" = "org.nomacs.ImageLounge.desktop";
          "image/tiff" = "org.nomacs.ImageLounge.desktop";
          "image/svg+xml" = "org.nomacs.ImageLounge.desktop";
          "image/x-icon" = "org.nomacs.ImageLounge.desktop";
          "audio/mpeg" = "vlc.desktop";
          "video/mp4" = "vlc.desktop";
          "video/quicktime" = "vlc.desktop";
          "video/vnd.avi" = "vlc.desktop";
          "application/x-compressed-tar" = "org.kde.ark.desktop";
          "x-scheme-handler/unknown" = "dms-open.desktop";
        };
      };
    };
  };
}