# Nix dots
- Thanks to [kaleocheng/nix-dots](https://github.com/kaleocheng/nix-dots/) for the base idea/structure.

## Usage
```bash
nix flake show
```
```bash
sudo nixos-rebuild switch --flake .#<hostname>
```
or with `nh`
```bash
nh os switch .#<hostname>
```

## Building installer ISOs
```bash
nix build .#nixosConfigurations.<hostname>-iso.config.system.build.isoImage
```

## Screenshots
### Sway flavor
<img width="1924" height="1080" alt="image" src="https://github.com/user-attachments/assets/acbdc8e4-487d-49c3-9370-25b71b4a2d92" />
