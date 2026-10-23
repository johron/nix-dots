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
              enabled = true;
              id = "dock_launcher";
              widgetId = "dockLauncher";
            }
            {
              enabled = true;
              id = "dock_apps";
              widgetId = "appsDock";
            }
            {
              enabled = true;
              id = "dock_trash";
              widgetId = "dockTrash";
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
          col = 0;
          enabled = true;
          h = 1;
          id = "user";
          row = 0;
          w = 5;
        }
        {
          col = 5;
          enabled = true;
          h = 1;
          id = "settings";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 6;
          enabled = true;
          h = 1;
          id = "lock";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 7;
          enabled = true;
          h = 1;
          id = "power";
          row = 0;
          small = true;
          w = 1;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "volumeSlider";
          row = 1;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "brightnessSlider";
          row = 1;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "wifi";
          row = 2;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "bluetooth";
          row = 2;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "audioOutput";
          row = 3;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "audioInput";
          row = 3;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "nightMode";
          row = 4;
          w = 4;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "idleInhibitor";
          row = 4;
          w = 4;
        }
        {
          col = 0;
          enabled = true;
          h = 1;
          id = "edit";
          row = 5;
          small = true;
          w = 1;
        }
        {
          col = 1;
          enabled = true;
          h = 1;
          id = "runningApps";
          row = 5;
          small = true;
          w = 3;
        }
        {
          col = 4;
          enabled = true;
          h = 1;
          id = "builtin_vpn";
          row = 5;
          w = 4;
        }
      ];
      appIdSubstitutions = [];
      clockDateFormat = "dddd, d. MMM";
      dashCards = [
        {
          id = "clock";
          w = 2;
          h = 1;
          col = 3;
          row = 0;
        }
        {
          id = "weather";
          w = 1;
          h = 1;
        }
        {
          id = "calendar";
          w = 5;
          h = 3;
          col = 0;
          row = 1;
        }
        {
          id = "media";
          w = 3;
          h = 1;
          col = 0;
          row = 0;
        }
      ];
      dashOptions = {
        overview = {
          panelColumns = 5;
          panelRows = 4;
        };
      };
      welbeingEnabled = false;
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
              clockNotificationBadge = false;
            }
          ];
          clickThrough = false;
          enabled = true;
          followInterfaceStyle = true;
          fontScale = 1;
          gothCornerRadiusOverride = false;
          gothCornerRadiusValue = 12;
          gothCornersEnabled = false;
          iconScale = 1;
          id = "default";
          innerPadding = -4;
          leftWidgets = [
            {
              enabled = true;
              id = "workspaceSwitcher";
              showWorkspaceApps = true;
              showWorkspaceIndex = true;
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
          widgetFollowInterfaceStyle = true;
          widgetOutlineColor = "primary";
          widgetOutlineEnabled = false;
          widgetOutlineOpacity = 1;
          widgetOutlineThickness = 1;
          widgetPadding = 8;
          widgetTransparency = 1;
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
        dms_qr_generator = {
          trigger = "qrg";
        };
        dms_power = {
          trigger = "pw";
        };
      };
      configVersion = 42;
    };
  };
}