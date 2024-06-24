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
    # might not what to hardcode this
    programs.git = {
      enable = true;
      userName = "Eradax";
      userEmail = "erikadebahr@gmail.com";
      # TODO: add
      # - init.defaultBranch main
      # [user]
      #   - name = Eradax
      #   - email = erikadebahr@gmail.com
      #   - signingkey = ~/.ssh/id_ed25519.pub
      # [core]
      #   - editor = nvim
      #   - excludesfile = ~/.gitignore

      # EXPLORE: git
      # - aliases
      # - color

      extraConfig = {
        init.defaultBranch = "main";
        safe.directory = [
          "${osConfig.modules.nixos.system.nix.cfg-path}"
          "${osConfig.modules.nixos.system.nix.cfg-path}/.git"
        ];
        pull.rebase = "false";
      };
    };
  };
}
