{
  osConfig,
  config,
  lib,
  pkgs,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.cli-apps.git;
in {
  options.modules.home.cli-apps.git =
    mkEnableOpt "Whether or not to add git";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      git-lfs
    ];

    programs.git = {
      enable = true;
      # TODO: Maybe use gpg instead of ssh
      aliases = {
        a = "add";
        aa = "add --all";

        d = "diff";

        pl = "pull";
        pu = "push";

        s = "status";

        c = "commit";
        cm = "commit -m";
        ca = "commit --amend";

        C = "clone";

        rb = "rebase";
        rba = "rebase --abort";
        rbc = "rebase --continue";
        rbi = "rebase --interactive";

        r = "restore";
        rs = "restore --staged";
      };
      delta = {
        enable = true;
        options = {
          navigate = true;
          dark = true;
          line-numbers = true;
        };
      };

      extraConfig = {
        url = {
          "git@github.com".insteadOf = "gh";
        };
        core = {
          editor = "nvim";
          eol = "lf";
          whitespace = "space-before-tab,trailing-space";
        };
        init = {
          defaultBranch = "main";
        };
        safe.directory = [
          # this is here because /persist/nixos/ isn't owned by us
          "${osConfig.modules.nixos.nix.cfg-path}"
          "${osConfig.modules.nixos.nix.cfg-path}/.git"
        ];
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        fetch.prune = true;
        apply.whitespace = "fix";
        # TODO: add or make it into an option: commit.template = "~/.gitmessage";
        gpg.format = "ssh";
      };

      signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };

      ignores = [
      ];

      attributes = [
        # Source files
        "*.c     text eol=lf diff=cpp"
        "*.cc    text eol=lf diff=cpp"
        "*.cxx   text eol=lf diff=cpp"
        "*.cpp   text eol=lf diff=cpp"
        "*.cpi   text eol=lf diff=cpp"
        "*.c++   text eol=lf diff=cpp"
        "*.hpp   text eol=lf diff=cpp"
        "*.h     text eol=lf diff=cpp"
        "*.h++   text eol=lf diff=cpp"
        "*.hh    text eol=lf diff=cpp"

        ".py  text eol=lf diff=python"
        ".py3 text eol=lf diff=python"

        "*.lua text eol=lf"

        "*.html text  eol=lf diff=html"
        "*.css  text  eol=lf diff=css"

        # Archives
        "*.7z   binary"
        "*.gz   binary"
        "*.tar  binary"
        "*.tgz  binary"
        "*.zip  binary"

        # Scripts
        "*.bash text eol=lf"
        "*.fish text eol=lf"
        "*.sh   text eol=lf"
        "*.zsh  text eol=lf"
        "*.nu   text eol=lf"

        # Executables
        "*.o    binary"
        "*.out  binary"

        # Normal text files
        "*.txt  text eol=lf"
        "*.csv  text eol=lf"
        "*.norg text eol=lf"
        "*.md   text eol=lf diff=markdown"
        "*.tex  text diff=tex"
      ];

      userName = "Eradax";
      userEmail = "erikadebahr@gmail.com";

      # TODO: Add merge conflict handling with eg. rebase

      # EXPLORE: git
      # - color
      # - url
      # - lfs
    };
  };
}
