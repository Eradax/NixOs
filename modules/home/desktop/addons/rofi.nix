{
  config,
  my_lib,
  lib,
  pkgs,
  ...
}: let
  inherit (my_lib.opt) mkEnableOpt;
  inherit (lib) mkIf;
  cfg = config.modules.home.desktop.addons.rofi;
in {
  options.modules.home.desktop.addons.rofi =
    mkEnableOpt "enables rofi, a application runner";

  config = mkIf cfg.enable {
    # TODO: rice
    programs.rofi = {
      enable = true;
      package = pkgs.rofi-wayland;
    };
  };
}
