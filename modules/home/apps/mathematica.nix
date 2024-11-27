{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.mathematica;
in {
  options.modules.home.apps.mathematica = mkEnableOpt "Wether or not to enable mathematica";
  # NOTE: Mathematica requires that Wolfram_14.1.0_LIN_Bndl.sh is in the nix-store
  # TODO: Declaratively add Wolfram_14.1.0_LIN_Bndl.sh to the nix-store

  config = mkIf cfg.enable {
    home.packages = [
      pkgs.mathematica
    ];
  };
}
