{
  description = "Nix Dotfiles with flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-26.05";
    home-manager = {
      url = "github:nix-community/home-manager/release-26.05";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-flatpak.url = "github:gmodena/nix-flatpak/?ref=v0.7.0";
  };

  outputs =
    {
      self,
      nix-flatpak,
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
            nix-flatpak.nixosModules.nix-flatpak
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
      nixosConfigurations."${hosts.dellaptop.hostname}" = mkNixOSConfigurations {
        host = hosts.dellaptop;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
      };

      homeConfigurations."${hosts.nixstation.user}@${hosts.nixstation.hostname}" = mkHomeConfigurations {
        host = hosts.nixstation;
        nixpkgs = inputs.nixpkgs;
        home-manager = inputs.home-manager;
      };
    };
}
