{ config, pkgs, ... }:

let
  users = import ../../../config/users.nix;
in
{
  news.display = "silent";

  home = {
    username = users.default;
    homeDirectory = "/home/${users.default}";
    stateVersion = "26.05";

    file.".mozilla/native-messaging-hosts/com.8bit.bitwarden.json".text = builtins.toJSON {
      name = "com.8bit.bitwarden";
      description = "Bitwarden desktop <-> browser bridge";
      path = "${pkgs.bitwarden-desktop}/bin/bitwarden";
      type = "stdio";
      allowed_extensions = [ "{446900e4-71c2-419f-a6a7-df9c091e268b}" ]; # Official Bitwarden Firefox Extension ID
    };
  };
}