{ config, pkgs, lib, inputs, ... }:

let
  users = import ./../../../../config/users.nix;
in
{
  programs.dank-material-shell = {
    settings = {
      currentThemeName = "dynamic";
      currentThemeCategory = "dynamic";
      customThemeFile = "/home/${users.default}/.config/DankMaterialShell/themes/gnomeAdwaita/theme.json";
      registryThemeVariants = {
        deepmono = {
          dark = {
            accent = "fog";
            flavor = "mono";
          };
        };
      };
      radiusStrength = 38;
      clockFormat = "24h";
      greeterEnableFprint = true;
      greeterEnableU2f = true;
      weatherEnabled = false;
      fontFamily = "Adwaita Sans";
      monoFontFamily = "Adwaita Mono";
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
      dockConfigs = [
        {
          id = "dock";
          name = "Dock";
          enabled = false;
          screenPreferences = [
            "all"
          ];
          showOnLastDisplay = false;
          position = 0;
          mode = "compact";
          taskbarAlign = "center";
          widgetExpansion = "popout";
          iconSize = 40;
          spacing = 4;
          itemSpacing = 4;
          margin = 0;
          bottomGap = 0;
          transparency = 1;
          followInterfaceStyle = true;
          autoHide = false;
          smartAutoHide = false;
          useOverlayLayer = false;
          editOnRightClick = false;
          showOnFullscreen = false;
          openOnOverview = false;
          groupByApp = false;
          separatePinnedAndRunningApps = false;
          restoreSpecialWorkspaceOnClick = false;
          isolateDisplays = false;
          indicatorStyle = "circle";
          borderEnabled = false;
          borderColor = "surfaceText";
          borderOpacity = 1;
          borderThickness = 1;
          launcherEnabled = false;
          launcherLogoMode = "apps";
          launcherLogoCustomPath = "";
          launcherLogoColorOverride = "";
          launcherLogoSizeOffset = 0;
          launcherLogoBrightness = 0.5;
          launcherLogoContrast = 1;
          maxVisibleApps = 0;
          maxVisibleRunningApps = 0;
          showOverflowBadge = true;
          showTrash = false;
          trashFileManager = "default";
          trashCustomCommand = "";
          magnification = false;
          magnificationScale = 130;
          magnificationProfile = "parabolic";
          magnificationExpand = false;
          order = [];
          widgets = [
            {
              id = "dock_launcher";
              widgetId = "dockLauncher";
              enabled = true;
            }
            {
              id = "dock_apps";
              widgetId = "appsDock";
              enabled = true;
            }
            {
              id = "dock_trash";
              widgetId = "dockTrash";
              enabled = true;
            }
          ];
        }
      ];
      matugenSpec = "2021";
      dmsWindowsFloatingSeeded = [
        "hyprland"
      ];
      syncComponentAnimationSpeeds = false;
      barElevationEnabled = false;
      controlCenterWidgets = [
        {
          id = "user";
          enabled = true;
          w = 5;
          h = 1;
          col = 0;
          row = 0;
        }
        {
          id = "settings";
          enabled = true;
          w = 1;
          h = 1;
          small = true;
          col = 5;
          row = 0;
        }
        {
          id = "lock";
          enabled = true;
          w = 1;
          h = 1;
          small = true;
          col = 6;
          row = 0;
        }
        {
          id = "power";
          enabled = true;
          w = 1;
          h = 1;
          small = true;
          col = 7;
          row = 0;
        }
        {
          enabled = true;
          id = "volumeSlider";
          w = 4;
          h = 1;
          col = 0;
          row = 1;
        }
        {
          enabled = true;
          id = "brightnessSlider";
          w = 4;
          h = 1;
          col = 4;
          row = 1;
        }
        {
          enabled = true;
          id = "wifi";
          w = 4;
          h = 1;
          col = 0;
          row = 2;
        }
        {
          enabled = true;
          id = "bluetooth";
          w = 4;
          h = 1;
          col = 4;
          row = 2;
        }
        {
          enabled = true;
          id = "audioOutput";
          w = 4;
          h = 1;
          col = 0;
          row = 3;
        }
        {
          enabled = true;
          id = "audioInput";
          w = 4;
          h = 1;
          col = 4;
          row = 3;
        }
        {
          enabled = true;
          id = "nightMode";
          w = 4;
          h = 1;
          col = 0;
          row = 4;
        }
        {
          enabled = true;
          id = "idleInhibitor";
          w = 4;
          h = 1;
          col = 4;
          row = 4;
        }
        {
          id = "edit";
          enabled = true;
          w = 1;
          h = 1;
          small = true;
          col = 0;
          row = 5;
        }
        {
          id = "runningApps";
          enabled = true;
          w = 3;
          h = 1;
          small = true;
          col = 1;
          row = 5;
        }
        {
          id = "builtin_vpn";
          enabled = true;
          w = 4;
          h = 1;
          col = 4;
          row = 5;
        }
      ];
      appIdSubstitutions = [];
      clockDateFormat = "dddd, d. MMM";
      networkPreference = "wifi";
      cursorSettings = {
        dwl = {
          cursorHideTimeout = 0;
        };
        hyprland = {
          hideOnKeyPress = false;
          hideOnTouch = false;
          inactiveTimeout = 0;
        };
        niri = {
          hideAfterInactiveMs = 0;
          hideWhenTyping = false;
        };
        size = 24;
        theme = "System Default";
      };
      acMonitorTimeout = 300;
      acLockTimeout = 300;
      acSuspendTimeout = 600;
      lockBeforeSuspend = true;
      enableFprint = true;
      enableU2f = true;
      notificationHistoryEnabled = false;
      notificationHistoryMaxAgeDays = 1;
      osdPowerProfileEnabled = true;
      updaterUseCustomCommand = true;
      updaterCustomCommand = "nix-update";
      screenPreferences = {
        notepad = [];
        notifications = [
          "all"
        ];
        wallpaper = [
          "all"
        ];
      };
      showOnLastDisplay = {
        notifications = true;
      };
      barConfigs = [
        {
          attachToScreenEdge = false;
          autoHide = false;
          autoHideDelay = 250;
          borderColor = "surfaceText";
          borderEnabled = false;
          borderOpacity = 1;
          borderThickness = 1;
          bottomGap = 0;
          centerWidgets = [
            {
              clockCompactMode = false;
              enabled = true;
              id = "clock";
            }
          ];
          clickThrough = false;
          enabled = true;
          fontScale = 1;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          gothCornersEnabled = false;
          iconScale = 1;
          id = "default";
          innerPadding = -4;
          leftWidgets = [
            {
              id = "workspaceSwitcher";
              enabled = true;
              showWorkspaceIndex = true;
              showWorkspaceApps = true;
            }
            {
              enabled = true;
              id = "music";
            }
          ];
          maximizeDetection = true;
          maximizeWidgetIcons = false;
          maximizeWidgetText = false;
          name = "Main Bar";
          noBackground = false;
          openOnOverview = false;
          popupGapsAuto = true;
          popupGapsManual = 0;
          position = 1;
          rightWidgets = [
            {
              enabled = true;
              id = "notificationButton";
            }
            {
              enabled = true;
              id = "systemTray";
            }
            {
              enabled = true;
              id = "usbManager";
            }
            {
              enabled = true;
              id = "battery";
            }
            {
              enabled = true;
              id = "controlCenterButton";
              showAudioPercent = false;
              showBatteryIcon = false;
              showBrightnessIcon = true;
              showBrightnessPercent = false;
              showMicIcon = true;
              showMicPercent = false;
              showPrinterIcon = false;
              showScreenSharingIcon = true;
            }
          ];
          screenPreferences = [
            "all"
          ];
          scrollEnabled = true;
          scrollXBehavior = "focusWindow";
          scrollYBehavior = "workspace";
          shadowColorMode = "text";
          shadowCustomColor = "#000000";
          shadowIntensity = 0;
          shadowOpacity = 60;
          showOnLastDisplay = true;
          showOnWindowsOpen = false;
          spacing = 0;
          squareCorners = true;
          transparency = 1;
          visible = true;
          widgetOutlineColor = "primary";
          widgetOutlineEnabled = false;
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          widgetPadding = 8;
          widgetTransparency = 1;
          followInterfaceStyle = true;
          widgetFollowInterfaceStyle = true;
        }
      ];
      builtInPluginSettings = {
        dms_clipboard_search = {
          trigger = "cb";
        };
        dms_notepad = {
          enabled = false;
        };
        dms_settings_search = {
          trigger = "?";
        };
      };
      configVersion = 42;
    };
  };
}