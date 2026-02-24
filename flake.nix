{
  description = "Nix Dotsfiles with flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    {
      self,
      ...
    }@inputs:

    let
      hosts = import ./config/hosts.nix;

      mkHomeConfigurations =
        {
          host,
          nixpkgs,
          home-manager,
          modules ? [ ],
        }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = import nixpkgs {
            system = host.arch;
            config = {
              allowUnfree = true;
            };
          };
          modules = [
            ./hosts/${host.dir}/home.nix
          ] ++ modules;
        };

      mkNixOSConfigurations =
        {
          host,
          nixpkgs,
          home-manager,
          modules ? [ ],
          overlays ? [ ],
        }:
        nixpkgs.lib.nixosSystem {
          system = host.arch;
          modules = [
            ./hosts/${host.dir}/configuration.nix
            { nixpkgs.overlays = overlays; }
            home-manager.nixosModules.home-manager
            {
              home-manager.useGlobalPkgs = true;
              home-manager.users."${host.user}" = import ./hosts/${host.dir}/home.nix;
            }
          ] ++ modules;
        };

    in
    {
      nixosConfigurations."${hosts.nixstation.hostname}" = mkNixOSConfigurations {
        host = hosts.nixstation;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
      };
      nixosConfigurations."${hosts.nixtop.hostname}" = mkNixOSConfigurations {
        host = hosts.nixtop;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
      };

      #homeConfigurations."${hosts.workstation.user}@${hosts.workstation.hostname}" = mkHomeConfigurations {
      #  host = hosts.workstation;
      #  nixpkgs = inputs.nixpkgs;
      #  home-manager = inputs.home-manager;
      #};

      #homeConfigurations."${hosts.wsl.hostname}" = mkHomeConfigurations {
      #  host = hosts.wsl;
      #  nixpkgs = inputs.nixpkgs-stable;
      #  home-manager = inputs.home-manager-stable;
      #};
    };
}
