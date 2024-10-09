{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    bind = $mod, R, submap, resize
    submap = resize
    binde = $mod, H, resizeactive, -10 0
    binde = $mod, L, resizeactive, 10 0
    binde = $mod, K, resizeactive, 0 -10
    binde = $mod, J, resizeactive, 0 10
  '';
}
