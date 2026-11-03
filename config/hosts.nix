let
  users = import ./users.nix;

  defaultHost = {
    arch = "x86_64-linux";
    user = users.default;
    kind = "nixos";
  };

  hosts = {
    straume = {};
    ideapad = {};
    lyderhorn = {};
    moholt = {
      user = users.server;
      kind = "server";
    };
    ono = {};
  };
in
builtins.mapAttrs (name: cfg:
  defaultHost // cfg // {
    hostname = name;
    dir = name;
    systemPath = if (cfg.kind or defaultHost.kind) == "server" then "server" else "nixos";
  }
) hosts