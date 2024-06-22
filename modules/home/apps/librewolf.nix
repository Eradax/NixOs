{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.librewolf;
in {
  options.modules.home.apps.librewolf = mkEnableOpt "Whether or not to enable librewolf.";

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.librewolf
    ];
  };
}
