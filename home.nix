{ config, pkgs, ... }:

{
  home.username = "andrey";
  home.homeDirectory = "/Users/andrey";

  home.stateVersion = "24.11";

  home.packages = with pkgs; [
    bash-language-server
    cargo
    charm-freeze
    curl
    emacs
    ffmpeg-full
    gh
    git
    glow
    go
    go-swagger
    go-task
    gofumpt
    golangci-lint
    golangci-lint-langserver
    golint
    gopls
    goreleaser
    gotests
    gotools
    gum
    helix
    helix-gpt
    htop
    lolcat
    jq
    micro
    ripgrep
    rustc
    rustfmt
    sequin
    tmux
    tree
    typescript-language-server
    vim
    vscode-langservers-extracted
    wget
    yaml-language-server
    yarn
    zsh-completions
  ];

  programs.git = {
    enable = true;
    userName = "Andrey Nering";
    userEmail = "andreynering@users.noreply.github.com";

    extraConfig = {
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
    };

    aliases = {
      br = "branch";
      ci = "commit";
      co = "checkout";
      dc = "diff --cached";
      st = "status";
      authors = "!git log --format='%an <%ae>' | sort -u";
      cleanup = "!git fetch -p && git branch -vv | awk '/: gone]/{print $1}' | xargs git br -D";
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

  initExtra = ''
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
  '';
  };

  programs.fish = {
    enable = true;

    interactiveShellInit = ''
      fish_config prompt choose arrow
    '';

    shellAliases = {
      t = "task";
    };
  };

  home.sessionPath = [
    "$HOME/go/bin"
  ];
  home.sessionVariables = {
    LESSCHARSET = "UTF-8";
    EDITOR = "hx";
    NVMDIR = "$HOME/.nvm";
  };

  programs.home-manager.enable = true;
}
