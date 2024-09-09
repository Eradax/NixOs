{
  config,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt enable;
  cfg = config.modules.home.cli-apps.pandoc;
in {
  options.modules.home.cli-apps.pandoc =
    mkEnableOpt "enable pandoc";

  config = mkIf cfg.enable {
    programs.pandoc = enable;
  };
}
