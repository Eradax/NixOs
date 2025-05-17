{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.obs;
in {
  options.modules.home.apps.obs =
    mkEnableOpt "Whether or not to enable OBS Studio";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      (wrapOBS {
        plugins = with obs-studio-plugins; [
        ];
      })
    ];
  };
}
