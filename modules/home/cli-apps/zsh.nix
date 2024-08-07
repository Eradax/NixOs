{
  config,
  my_lib,
  lib,
  pkgs,
  ...
}: let
  inherit (my_lib.opt) mkEnableOpt enable mkBoolOpt;
  inherit (lib) mkIf;
  cfg = config.modules.home.cli-apps.zsh;
in {
  options.modules.home.cli-apps.zsh =
    mkEnableOpt
    "enables the zsh shell"
    // {
      set-shell = mkBoolOpt false "sets the users shell to zsh";
    };

  config = mkIf cfg.enable {
    # xdg.configFile."shell".source = mkIf cfg.set-shell (lib.getExe pkgs.zsh);
    xdg.configFile."shell" = {
      executable = true;
      text = ''
        #!/bin/sh
        exec ${pkgs.zsh}/bin/zsh "$@"
      '';
    };

    programs = {
      zsh = {
        enable = true;
        enableCompletion = true;
        autosuggestion = enable;
        syntaxHighlighting = enable;

        shellAliases = {
          # s = "doas -s";
          # sudo = "doas -s";
          un-page = "env PAGER=cat";
          ds = "dev-shell";
          e = "$EDITOR";
          c = "clear";
          ".." = "cd ..";
          "..." = "cd ../..";
          "...." = "cd ../../..";
          "....." = "cd ../../../..";
          l1 = "tree -L 1";
          l2 = "tree -L 2";
          l3 = "tree -L 3";
          l4 = "tree -L 4";
        };

        # dotDir = "./config/zsh";
        history = {
          size = 10000;
          # path = "$HOME/.zsh-test/history";
        };
      };

      starship = {
        enable = true;
        settings = {
          # format = "\${custom.simple_nix_shell}$directory$character";
          format = "$nix_shell$directory$character";
          add_newline = true;

          directory = {
            truncate_to_repo = false;
            read_only = "";
            truncation_symbol = ".../";
          };

          # right_format = "$all";
          character = {
            success_symbol = "[➜](bold green)";
            error_symbol = "[➜](bold red)";
            # vicmd_symbol = "[](bold blue) ";
          };

          nix_shell = {
            impure_msg = "[❄️](bold red)";
            pure_msg = "[❄️](bold green)";
            unknown_msg = "[❄️](bold yellow)";
            format = "[\\[$state $name\\]](bold blue) ";
          };

          /*
          custom.simple_nix_shell = {
            command = ''
              if [[ "$IN_NIX_SHELL" == "impure" ]]; then
                pure_icon="-";

              elif [[ "$IN_NIX_SHELL" == "pure" ]]; then
                pure_icon="+";

              elif [[ "$IN_NIX_SHELL" == "unknown" ]]; then
                pure_icon="o";

              else;
                echo "wut"
              fi

              echo "$pure_icon $name"
            '';
            when = "if [[ $name == '' ]]; then exit 1; fi";
            format = "[\\[❄️ $output\\]](bright-cyan) ";
          };
          */
        };
      };
    };
  };
}
