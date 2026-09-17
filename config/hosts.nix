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
  lyderhorn = {
    hostname = "lyderhorn";
    dir = "lyderhorn";
    arch = "x86_64-linux";
    user = users.default;  
  };
  moholt = {
    hostname = "moholt";
    dir = "moholt";
    arch = "x86_64-linux";
    user = users.server; 
  };
  ono = {
    hostname = "ono";
    dir = "ono";
    arch = "x86_64-linux";
    user = users.server; 
  };
}