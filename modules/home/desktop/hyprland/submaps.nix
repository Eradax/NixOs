{...}: {
  wayland.windowManager.hyprland.extraConfig = ''
    bind = $mod, R, exec, echo -n "Resize" > /tmp/hypr_submap
    bind = $mod, R, submap, resize

    submap = resize
    binde = $mod, H, resizeactive, -10 0
    binde = $mod, L, resizeactive, 10 0
    binde = $mod, K, resizeactive, 0 -10
    binde = $mod, J, resizeactive, 0 10

    bind = , escape, exec, truncate -s 0 /tmp/hypr_submap
    bind = , escape, submap, reset
    submap = reset
  '';
}
