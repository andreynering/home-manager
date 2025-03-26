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

  programs.neovim = {
    enable = true;

    plugins = with pkgs.vimPlugins; [
      catppuccin-nvim
      coc-nvim
      neo-tree-nvim
      nvim-lspconfig
    ];

    extraConfig = ''
      " catppuccin
      set termguicolors
      lua << EOF
        require("catppuccin").setup({
          flavour = "mocha", -- latte, frappe, macchiato, mocha
          background = {
           light = "latte",
           dark = "mocha",
         },
         transparent_background = false,
         term_colors = true,
         integrations = {
           cmp = true,
           gitsigns = true,
           nvimtree = true,
           telescope = true,
           which_key = true,
         }
       })
       vim.cmd.colorscheme "catppuccin"
      EOF
    '';
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
    LANG = "en_US.utf8";
    EDITOR = "hx";
    LESSCHARSET = "UTF-8";
    NVMDIR = "$HOME/.nvm";
  };

  programs.home-manager.enable = true;
}
