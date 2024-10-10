{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.anki;
in {
  options.modules.home.apps.anki = mkEnableOpt "Whether or not to enable anki.";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.anki
    ];
  };
}
