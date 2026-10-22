{ config, pkgs, lib, inputs, ... }:

{
  programs.dank-material-shell = {
    clipboardSettings = {
      maxHistory = 1000;
      maxEntrySize = 5242880;
      autoClearDays = 3;
      clearAtStartup = false;
      disabled = false;
      disableHistory = false;
      disablePersist = false;
    };
  };
}