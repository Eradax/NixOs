{
  osConfig,
  config,
  lib,
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
    programs.git = {
      enable = true;
      # FIX: go from SSH to GPG keys
      aliases = {
        # add all git aliases here
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
        core = {
          editor = "nvim";
          eol = "lf";
          whitespace = "space-before-tab,trailing-space";
        };
        init = {
          defaultBranch = "main";
        };
        safe.directory = [
          "${osConfig.modules.nixos.nix.cfg-path}" # this is here coz /persist/nixos/ isn't owned by us
          "${osConfig.modules.nixos.nix.cfg-path}/.git" # this is here coz /persist/nixos/ isn't owned by us
        ];
        merge.conflictstyle = "diff3";
        diff.colorMoved = "default";
        fetch.prune = true;
        apply.whitespace = "fix";
        # TODO: add or make it into an option: commit.template = "~/.gitmessage";
        gpg.format = "ssh"; # FIXME: use gpg instead of ssh, and an agent
      };

      signing = {
        key = "~/.ssh/id_ed25519.pub";
        signByDefault = true;
      };

      ignores = [
      ];

      attributes = [
      ];

      userName = "Eradax";
      userEmail = "erikadebahr@gmail.com";

      # TODO: Add merge conflict handling with eg. rebase
      # EXPLORE: git
      # - aliases
      # - color
      # - url
      # - lfs
    };
  };
}
