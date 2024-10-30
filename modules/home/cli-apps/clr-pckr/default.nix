{
  config,
  lib,
  pkgs,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.cli-apps.clr-pckr;
in {
  options.modules.home.cli-apps.clr-pckr =
    mkEnableOpt
    "Whether or not to add the clr-pckr command";

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "clr-pckr"
        /*
        Bash
        */
        ''
          LOCKFILE="/run/user/$(id -u)/clr-pckr.lock"

          if [ -e "$LOCKFILE" ]; then
              PID=$(cat "$LOCKFILE")

              if kill -0 "$PID" 2>/dev/null; then
                  echo "Script is already running with PID $PID. Exiting..."
                  exit 1
              else
                  echo "Stale lock file found. Cleaning it up..."
                  rm -f "$LOCKFILE"
              fi
          fi

          echo $$ > "$LOCKFILE"
          trap 'rm -f "$LOCKFILE"' INT QUIT ABRT ALRM TERM

          color=$(hyprpicker -n)

          if test -z "$color"; then
              echo "Program aborted by user. Exiting..."
              exit 1
          fi

          wl-copy "$color"
          echo "$color"

          # Generated with https://interfacecraft.online/squircle-svg-generator/
          # However it is far from perfect so I have also made som manual changes
          # using inkscape.
          squircle_black="${./squircle.svg}"
          squircle_color=$(mktemp --suffix=.svg)

          if test -z "$squircle_color"; then
              echo "Failed to generate tmp file. Exiting..."
              exit 1
          fi

          sed "s/#000000/$color/" "$squircle_black" > "$squircle_color"

          notify-send --icon "$squircle_color" "Hyprpicker" "$color"

          rm "$squircle_color"

          rm -f "$LOCKFILE"
        '')
    ];
  };
}
