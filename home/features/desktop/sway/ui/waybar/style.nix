{ pkgs, lib, ... }:

{
  programs.waybar = {
    style = ''
      * {
        border: none;
        font-family: "JetBrainsMono Nerd Font", "Material Symbols Outlined";
        font-size: 12px;
        font-weight: 700;
      }

      window#waybar {
        /*background: rgb(26,28,23);*/
        background: rgb(10,1,1);
        border-radius: 0px;
      }

      #custom-clock,
      #tray,
      #mpris,
      #workspaces,
      #mode,
      #workspace button {
        background: rgb(20,2,2);

        color: #e6e1e5;

        min-width: 12px;
        min-height: 12px;
        padding: 0 6px;
        margin: 2px 2px;
        border-radius: 10px;

        /*border: 1px solid rgba(255,255,255,0.08);*/
        transition: all 0.2s ease;
      }

      #mode {
        background: rgba(57, 150, 181, 0.1);
        font-family: "Material Symbols Outlined";
      }

      #workspaces {
        padding: 0;
      }

      #workspaces button label {
        padding: 0;
        margin: 0;
      }

      #workspaces button.active,
      #workspaces button.focused {
        background: rgba(57, 150, 181, 0.1);
        color: white;
      }

      #workspaces button.urgent {
        background: rgba(65, 3, 3, 0.9);
      }

      #workspaces button:hover {
        background: rgba(255,255,255,0.08);
      }

      #mpris.playing {
        background: rgba(57, 150, 181, 0.1);
      }

      #mpris.spotify.playing {
        background: rgba(29,185,84,0.1);
      }

      #mpris.firefox.playing {
        background: rgba(255,102,42,0.1);
      }

      #pulseaudio,
      #network,
      #bluetooth,
      #battery,
      #custom-taskmgr {
        font-family: "Material Symbols Outlined";
        background: rgb(20,2,2);
        color: #e6e1e5;
        font-weight: 600;

        padding: 0 6px;
        margin: 2px 0;
        border-radius: 0;

        /*border-top: 1px solid rgba(255,255,255,0.08);
        border-bottom: 1px solid rgba(255,255,255,0.08);*/
      }

      #pulseaudio {
        font-size: 18px;
      }

      #bluetooth,
      #network {
        font-size: 14px;
      }

      #custom-cap-left {
        background: rgb(20,2,2);
        margin: 2px 0 2px 2px;

        border-radius: 12px 0 0 12px;
        padding: 0 1px;

        /*border: 1px solid rgba(255,255,255,0.08);
        border-right: none;*/
      }

      #custom-cap-right {
        background: rgb(20,2,2);
        margin: 2px 2px 2px 0;

        border-radius: 0 12px 12px 0;
        padding: 0 1px;

        /*border: 1px solid rgba(255,255,255,0.08);
        border-left: none;*/
      }
    '';
  };
}