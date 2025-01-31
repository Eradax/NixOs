{
  config,
  my_lib,
  lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (my_lib.opt) mkEnableOpt;
  inherit (lib) mkIf;
  cfg = config.modules.home.desktop.hyprland;
in {
  imports = [
    ./binds.nix
    ./config.nix
    ./monitors.nix
    ./submaps.nix
    inputs.hyprland.homeManagerModules.default
  ];

  options.modules.home.desktop.hyprland =
    mkEnableOpt "enables hyperland, a wayland tiling manager";

  config = mkIf cfg.enable {
    home.packages = with pkgs; [
      brightnessctl
      hyprpicker
      grimblast
    ];

    wayland.windowManager.hyprland = {
      # Whether to enable Hyprland wayland compositor
      enable = true;
      # The hyprland package to use
      package = pkgs.hyprland;
      # Whether to enable XWayland
      xwayland.enable = true;

      # Optional
      # Whether to enable hyprland-session.target on hyprland startup
      systemd.enable = true;
    };
    # wayland.windowManager.hyprland.enable = true;
  };
}
