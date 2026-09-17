let
  users = import ./users.nix;

  defaultHost = {
    arch = "x86_64-linux";
    user = users.default;
  };

  hosts = {
    nixstation = {};
    ideapad = {};
    lyderhorn = {};
    moholt = { user = users.server; };
    ono = {};
  };
in
builtins.mapAttrs (name: cfg: 
  defaultHost // cfg // {
    hostname = name;
    dir = name;
  }
) hosts