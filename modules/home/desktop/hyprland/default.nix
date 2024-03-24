{
  config,
  my_lib,
  lib,
  ...
}: let
  inherit (my_lib.opt) mkEnableOpt;
  inherit (lib) mkIf;
  cfg = config.modules.home.desktop.hyprland;
in {
  imports = [
    ./config.nix
  ];

  options.modules.home.desktop.hyprland =
    mkEnableOpt "enables hyperland, a wayland tiling manager";

  config = mkIf cfg.enable {
    wayland.windowManager.hyprland.enable = true;
  };
}
