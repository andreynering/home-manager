# home-manager

My [home-manager][homemanager] configuration.

## How to fix a broken Nix / home-manager after a macOS update

1. Remove these files if present (backup in doubt).

```bash
sudo rm -f /etc/bash.bashrc.backup-before-nix
sudo rm -f /etc/bashrc.backup-before-nix
sudo rm -f /etc/zshrc.backup-before-nix
```

2. Reinstall Nix:

```bash
sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
```

3. Reinstall `home-manager`:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

[homemanager]: https://nix-community.github.io/home-manager/
