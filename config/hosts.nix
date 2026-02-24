let
  users = import ./users.nix;
in
{
  nixstation = {
    hostname = "nixstation";
    dir = "desktop-nixos-workstation";
    arch = "x86_64-linux";
    user = users.default;
  };
  nixtop = {
    hostname = "nixtop";
    dir = "laptop-nixos-dell";
    arch = "x86_64-linux";
    user = users.default;  
  };
}