let
  users = import ./users.nix;
in
{
  nixstation = {
    hostname = "nixstation";
    dir = "nixstation";
    arch = "x86_64-linux";
    user = users.default;
  };
  dellaptop = {
    hostname = "dellaptop";
    dir = "dellaptop";
    arch = "x86_64-linux";
    user = users.default;  
  };
}