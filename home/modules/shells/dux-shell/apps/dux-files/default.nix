{ pkgs, inputs, ... }:

{
  imports = [
    inputs.dux-files.homeModules.default
  ];

  home.file.".config/dfiles/bookmarks.json".source = ./bookmarks.json;
  home.file.".config/dfiles/servers.json".source = ./servers.json;

  programs.dux-files = {
    enable = true;

    systemd = {
      enable = true;
      target = "graphical-session.target";
      restartIfChanged = true;
    };

    settings = {
      animationDuration = 250;
      clickToOpen = "double";
      closeBehavior = "hide";
      colorSource = "auto";
      confirmTrash = false;
      customThemeFile = "";
      defaultSort = "name";
      defaultSortDescending = false;
      defaultView = "list";
      displayFontFamily = "";
      dragAction = "auto";
      enableRippleEffects = true;
      extractOnOpen = true;
      focusRingColor = "primary";
      focusRingEnabled = true;
      focusRingWidth = 1.5;
      folderCounts = true;
      foldersFirst = true;
      fontFamily = "";
      fontScale = 1;
      fontSource = "auto";
      fontWeight = 400;
      gtkBookmarksOffered = true;
      language = "";
      listTyping = "jump";
      monoFontFamily = "";
      mountOnClick = true;
      networkThumbnails = false;
      openLocationIn = "tab";
      presetTheme = "purple";
      radiusStrength = 50;
      recentFiles = true;
      reduceMotion = false;
      registerFileManager = true;
      rememberFolderViews = true;
      searchExcludes = [];
      searchHidden = false;
      showExtensions = true;
      showHidden = false;
      showSystemPartitions = false;
      sidebarCollapsed = false;
      springBounce = 1;
      terminal = "alacritty";
      themeMode = "auto";
      thumbnailSizeLimitMb = 64;
      thumbnails = true;
      vimKeys = false;
      windowTitleBars = false;
    };

    portal = {
      enable = true;
      preferred = true;
      desktop = "hyprland";
    };
  };
}