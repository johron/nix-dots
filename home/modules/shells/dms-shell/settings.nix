{ config, pkgs, lib, inputs, ... }:

{
  programs.dank-material-shell = {
    settings = {
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      customThemeFile = "/home/johron/.config/DankMaterialShell/themes/gnomeAdwaita/theme.json";
      registryThemeVariants = {
        deepmono = {
          dark = {
            flavor = "mono";
            accent = "fog";
          };
        };
      };
      wallpaperPath = "/home/johron/Pictures/shell-imgs/bg.png";
      cornerRadius = 12;
      clockFormat = "24h";
      syncComponentAnimationSpeeds = false;
      barElevationEnabled = false;
      showWeather = false;
      controlCenterShowMicPercent = true;
      controlCenterWidgets = [
        {
          id = "volumeSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "brightnessSlider";
          enabled = true;
          width = 50;
        }
        {
          id = "wifi";
          enabled = true;
          width = 50;
        }
        {
          id = "bluetooth";
          enabled = true;
          width = 50;
        }
        {
          id = "audioOutput";
          enabled = true;
          width = 50;
        }
        {
          id = "audioInput";
          enabled = true;
          width = 50;
        }
        {
          id = "nightMode";
          enabled = true;
          width = 50;
        }
        {
          id = "idleInhibitor";
          enabled = true;
          width = 50;
        }
      ];
      showWorkspaceIndex = true;
      showWorkspaceApps = true;
      appIdSubstitutions = [];
      clockDateFormat = "dddd, d. MMM";
      greeterEnableFprint = true;
      greeterEnableU2f = true;
      greeterWallpaperPath = "/home/johron/Pictures/shell-imgs/bg.png";
      weatherEnabled = false;
      networkPreference = "wifi";
      cursorSettings = {
        theme = "System Default";
        size = 24;
        niri = {
          hideWhenTyping = false;
          hideAfterInactiveMs = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        dwl = {
          cursorHideTimeout = 0;
        };
      };
      fontFamily = "Adwaita Sans";
      monoFontFamily = "Adwaita Mono";
      acMonitorTimeout = 300;
      acLockTimeout = 300;
      acSuspendTimeout = 600;
      lockBeforeSuspend = true;
      dockPosition = 0;
      enableFprint = true;
      enableU2f = true;
      notificationHistoryEnabled = false;
      notificationHistoryMaxAgeDays = 1;
      osdPowerProfileEnabled = true;
      powerMenuActions = [
        "reboot"
        "logout"
        "poweroff"
        "lock"
        "suspend"
        "restart"
        "hibernate"
      ];
      powerMenuDefaultAction = "poweroff";
      updaterUseCustomCommand = true;
      updaterCustomCommand = "nix-update";
      screenPreferences = {
        dock = [];
        notifications = [
          "all"
        ];
        wallpaper = [
          "all"
        ];
        notepad = [];
      };
      showOnLastDisplay = {
        dock = false;
        notifications = true;
      };
      barConfigs = [
        {
          id = "default";
          name = "Main Bar";
          enabled = true;
          position = 1;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = true;
          leftWidgets = [
            "workspaceSwitcher"
            {
              id = "music";
              enabled = true;
            }
          ];
          centerWidgets = [
            {
              id = "clock";
              enabled = true;
              clockCompactMode = false;
            }
          ];
          rightWidgets = [
            {
              id = "notificationButton";
              enabled = true;
            }
            {
              id = "systemTray";
              enabled = true;
            }
            {
              id = "usbManager";
              enabled = true;
            }
            {
              id = "battery";
              enabled = true;
            }
            {
              id = "controlCenterButton";
              enabled = true;
              showAudioPercent = false;
              showBrightnessIcon = true;
              showBrightnessPercent = false;
              showMicIcon = true;
              showMicPercent = false;
              showBatteryIcon = false;
              showPrinterIcon = false;
              showScreenSharingIcon = true;
            }
          ];
          spacing = 0;
          innerPadding = -4;
          bottomGap = 0;
          transparency = 1;
          widgetTransparency = 1;
          squareCorners = true;
          noBackground = false;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          removeWidgetPadding = false;
          widgetPadding = 8;
          gothCornersEnabled = false;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          widgetOutlineEnabled = false;
          widgetOutlineColor = "primary";
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          fontScale = 1;
          iconScale = 1;
          autoHide = false;
          autoHideDelay = 250;
          showOnWindowsOpen = false;
          openOnOverview = false;
          visible = true;
          popupGapsAuto = true;
          popupGapsManual = 0;
          maximizeDetection = true;
          scrollEnabled = true;
          scrollXBehavior = "column";
          scrollYBehavior = "workspace";
          shadowIntensity = 0;
          shadowOpacity = 60;
          shadowColorMode = "text";
          shadowCustomColor = "#000000";
          clickThrough = false;
          attachToScreenEdge = false;
        }
      ];
      desktopClockCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      systemMonitorCustomColor = {
        r = 1;
        g = 1;
        b = 1;
        a = 1;
        hsvHue = -1;
        hsvSaturation = 0;
        hsvValue = 1;
        hslHue = -1;
        hslSaturation = 0;
        hslLightness = 1;
        valid = true;
      };
      builtInPluginSettings = {
        dms_settings_search = {
          trigger = "?";
        };
        dms_notepad = {
          enabled = false;
        };
        dms_clipboard_search = {
          trigger = "cb";
        };
      };
      configVersion = 17;
    };
  };
}