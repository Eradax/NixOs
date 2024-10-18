{
  config,
  lib,
  pkgs,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.cli-apps.cn-bth;
in {
  options.modules.home.cli-apps.cn-bth =
    mkEnableOpt
    "Whether or not to add the cn-bth command";

  # TODO: auto connect to bth?
  #  https://github.com/EzequielRamis/dotfiles/blob/ecfe6f269339d1551768b9158c1d3aee2d82b238/home/timers.nix#L19

  config = mkIf cfg.enable {
    home.packages = [
      (pkgs.writeShellScriptBin "clr-pckr" ''
        color=$(hyprpicker -n)

        if test -z "$color"; then
            echo "Program aborted by user. Exiting..."
            exit 1
        fi

        wl-copy "$color"

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
      '')
    ];
  };
}
