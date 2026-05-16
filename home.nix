{ config, pkgs, ... }:

let
  pkgsUnstable = import <nixos-unstable> {};
in
{
  home.username = "andrey";
  home.homeDirectory = if pkgs.stdenv.isDarwin
    then "/Users/andrey"
    else "/home/andrey";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    _1password-cli
    bash
    bash-completion
    caddy
    curl
    duf
    esbuild
    git
    grype
    (google-cloud-sdk.withExtraComponents [
      google-cloud-sdk.components.gke-gcloud-auth-plugin
    ])
    htop
    pkg-config
    lolcat
    p7zip
    poppler
    resvg
    tree
    typescript-language-server
    vim
    wget
    zsh-completions
    zstd
  ];

  programs.git = {
    enable = true;

    lfs = {
      enable = true;
    };

    signing = {
      key = "${config.home.homeDirectory}/.ssh/id_ed25519.pub";
      signByDefault = true;
    };

    settings = {
      user = {
        name = "Andrey Nering";
        email = "andreynering@users.noreply.github.com";
      };

      gpg = {
        format = "ssh";
      };

      "gpg.ssh" = {
        allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
      };

      init = {
        defaultBranch = "main";
      };

      core = {
        excludesFile = "~/.config/.gitignore";
      };

      status = {
        showUntrackedFiles = "all";
      };

      fetch = {
        prune = true;
      };

      alias = {
        br = "branch";
        ci = "commit";
        co = "checkout";
        dc = "diff --cached";
        st = "status";
        cp = "cherry-pick";
        authors = "!git log --format='%an <%ae>' | sort -u";
        cleanup = "!git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git br -D";
        do-gc = "!f() { git reflog expire --all --expire=now && git gc --prune=now --aggressive; }; f";
        fixup = "commit --fixup";
        stash-all = "stash save --include-untracked";
        undo = "reset --soft HEAD^";
      };
    };
  };

  programs.zsh = {
    enable = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;

    oh-my-zsh = {
      enable = true;
      theme = "robbyrussell";

      plugins = [
        "docker"
        "git"
        "kubectl"
        "node"
        "npm"
      ];
    };

    shellAliases = {
      t = "task";
      p = "git pull && git cleanup && task -ls | grep -q install && task install";
      y = "yazi";
      z = "zellij";
    };

    initContent = ''
      eval "$(mise activate zsh)"
    '';
  };

  home.sessionPath = [
    "$HOME/.local/bin"
  ];
  home.sessionVariables = {
    NIXPKGS_ALLOW_UNFREE = "1";
  };

  programs.home-manager.enable = true;
}
