# home-manager

My [home-manager][homemanager] configuration.

## How to fix a broken Nix / home-manager after a macOS update

1. Reinstall Nix:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

2. Reinstall `home-manager`:

```
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

[homemanager]: https://nix-community.github.io/home-manager/
