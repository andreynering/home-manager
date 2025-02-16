{ config, pkgs, ... }:

{
  home.username = "andrey";
  home.homeDirectory = "/Users/andrey";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    cargo
    curl
    ffmpeg-full
    gh
    git
    go
    go-task
    golangci-lint
    goreleaser
    htop
    jq
    micro
    nodejs_22
    ripgrep
    rustc
    rustfmt
    sequin
    tmux
    tree
    vim
    wget
    yarn
    zsh-completions
  ];

  programs.git = {
    enable = true;
    userName = "Andrey Nering";
    userEmail = "andreynering@users.noreply.github.com";

    extraConfig = {
      core = {
        excludesFile = "~/.config/.gitignore";
      };
      status = {
        showUntrackedFiles = "all";
      };
    };

    aliases = {
      br = "branch";
      ci = "commit";
      co = "checkout";
      dc = "diff --cached";
      st = "status";
      authors = "!git log --format='%an <%ae>' | sort -u";
      cleanup = "!git branch -vv | awk '/: gone]/{print $1}' | xargs git br -D";
      do-gc = "!f() { git reflog expire --all --expire=now && git gc --prune=now --aggressive; }; f";
      do-merge = "!f() { git merge --no-ff $1 && git branch -d $1; }; f";
      fixup = "commit --fixup";
      stash-all = "stash save --include-untracked";
      undo = "reset --soft HEAD^";
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
    };
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
  home.sessionVariables = {
    EDITOR = "micro";
  };

  programs.home-manager.enable = true;
}
