{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.inkscape;
in {
  options.modules.home.apps.inkscape = mkEnableOpt "Whether or not to enable inkscape.";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.inkscape
    ];
  };
}
