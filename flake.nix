{
  description = "Nix Dotfiles with flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
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

      mkISOConfiguration =
        {
          host,
          nixpkgs,
        }:
        nixpkgs.lib.nixosSystem {
          system = host.arch;
          modules = [
            nix-flatpak.nixosModules.nix-flatpak
            "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-graphical-calamares-plasma6.nix"
            ./hosts/iso/configuration.nix
            {
              # ISO-specific configuration
              image.fileName = "${host.hostname}-installer.iso";
              isoImage.volumeID = "${builtins.substring 0 11 host.hostname}";
            }
          ];
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

      isos.nixstation = (mkISOConfiguration {
        host = hosts.nixstation;
        nixpkgs = inputs.nixpkgs;
      }).config.system.build.isoImage;

      isos.nixtop = (mkISOConfiguration {
        host = hosts.nixtop;
        nixpkgs = inputs.nixpkgs;
      }).config.system.build.isoImage;

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
