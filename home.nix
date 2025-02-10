{ config, pkgs, ... }:

{
  # Home Manager needs a bit of information about you and the paths it should
  # manage.
  home.username = "guy";
  home.homeDirectory = "/Users/guy";

  # Configure nixpkgs
  nixpkgs.config.allowUnfree = true;

  # This value determines the Home Manager release that your configuration is
  # compatible with. This helps avoid breakage when a new Home Manager release
  # introduces backwards incompatible changes.
  #
  # You should not change this value, even if you update Home Manager. If you do
  # want to update the value, then make sure to first check the Home Manager
  # release notes.
  home.stateVersion = "24.11"; # Please read the comment before changing.

  # The home.packages option allows you to install Nix packages into your
  # environment.
  home.packages =
    [ #Environment Support
      pkgs.direnv
      pkgs.zellij

      # Fonts
      pkgs.fira-code

      # Nix Support
      pkgs.nixd
      pkgs.nixpkgs-fmt

      # TOML Support
      pkgs.taplo
    ];

  # Home Manager is pretty good at managing dotfiles. The primary way to manage
  # plain files is through 'home.file'.
  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    ".config/helix" = {
      source = ./helix;
      recursive = true;
    };

    ".config/zellij" = {
      source = ./zellij;
      recursive = true;
    };
  };

  # Home Manager can also manage your environment variables through
  # 'home.sessionVariables'. These will be explicitly sourced when using a
  # shell provided by Home Manager. If you don't want to manage your shell
  # through Home Manager then you have to manually source 'hm-session-vars.sh'
  # located at either
  home.sessionVariables = {
    EDITOR = "hx";
  };

  # Let Home Manager install and manage itself.
  programs = {
    home-manager.enable = true;

    zsh = {
      enable = true;

      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;

      oh-my-zsh = {
        enable = true;
        theme = "lukerandall";

        plugins =
        [ "history"
          "git"
        ];
      };
    };

    git = {
      enable = true;

      userName = "Guy Marino";
      userEmail = "gmarino2048@gmail.com";

      lfs.enable = true;

      extraConfig = {
        init.defaultBranch = "main";
      };
    };

    ssh = {
      enable = true;

      matchBlocks = {
        "github.com" = {
          host = "github.com";
          hostname = "github.com";
          user = "git";
          identityFile = "~/.ssh/github-auth";
          identitiesOnly = true;
        };
      };
    };

    vscode = {
      enable = true;

      userSettings = {
        "window.autoDetectColorScheme" = true;

        "files.autoSave" = "afterDelay";
        "files.trimTrailingWhitespace" = true;
      };

      extensions = with pkgs.vscode-extensions;
        [ jnoortheen.nix-ide
          mkhl.direnv
        ];
    };

  };
}
