{ pkgs, lib, ... }:
{
  home.packages = with pkgs; [
    kdePackages.breeze
    kdePackages.breeze-gtk
    kdePackages.breeze-icons
  ];

  gtk = {
    enable = true;
    theme = {
      name = "Breeze-Dark";
      package = pkgs.kdePackages.breeze-gtk;
    };
    iconTheme = {
      name = "breeze-dark";
      package = pkgs.kdePackages.breeze-icons;
    };
  };

  home = {
    file = {
      kdeglobals = {
        target = ".config/kdeglobals";
        text = ''
          [UiSettings]
          ColorScheme=BreezeDark

          [KDE]
          ShowDeleteCommand=true

          [KFileDialog Settings]
          Allow Expansion=false
          Automatically select filename extension=true
          Breadcrumb Navigation=true
          Decoration position=2
          Show Full Path=false
          Show Inline Previews=true
          Show Preview=false
          Show Speedbar=true
          Show hidden files=false
          Sort by=Name
          Sort directories first=true
          Sort hidden files last=false
          Sort reversed=false
          Speedbar Width=144
          View Style=Simple

          [PreviewSettings]
          EnableRemoteFolderThumbnail=false
          MaximumRemoteSize=0
        '';
      };
    };
  };
}