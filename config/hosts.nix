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
  ideapad = {
    hostname = "ideapad";
    dir = "ideapad";
    arch = "x86_64-linux";
    user = users.default;  
  };
}