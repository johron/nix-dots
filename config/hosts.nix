let
  users = import ./users.nix;

  defaultHost = {
    arch = "x86_64-linux";
    user = users.default;
    # "nixos" = desktop/workstation (hosts/<name>/nixos + home)
    # "server" = headless server  (hosts/<name>/server, no home-manager)
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
    kind = cfg.kind or defaultHost.kind;
    systemPath = if (cfg.kind or defaultHost.kind) == "server" then "server" else "nixos";
  }
) hosts