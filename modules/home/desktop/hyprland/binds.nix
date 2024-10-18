{...}: let
  mod = a: b: a - builtins.floor (a / b) * b;
in {
  wayland.windowManager.hyprland = {
    settings = {
      "$mod" = "SUPER";

      # bind flags
      /*
      l -> locked, will also work when an input inhibitor (e.g. a
      lockscreen) is active.

      r -> release, will trigger on release of a key.

      e -> repeat, will repeat when held.

      n -> non-consuming, key/mouse events will be passed to the
      active window in addition to triggering the dispatcher.

      m -> mouse, see below

      t -> transparent, cannot be shadowed by other binds.

      i -> ignore mods, will ignore modifiers.
      */

      # mouse binds
      bindm = [
        "$mod, mouse:272, movewindow"
        "$mod, mouse:273, resizewindow"
      ];

      bindle = [
        # change volume
        ",XF86AudioMute, exec, pamixer -t"
        ",XF86AudioRaiseVolume, exec, pamixer -i 5"
        ",XF86AudioLowerVolume, exec, pamixer -d 5"
        # change brigtness
        ",XF86MonBrightnessUp, exec, brightnessctl --exponent=1.9 set 5%+"
        ",XF86MonBrightnessDown, exec, brightnessctl --exponent=1.9 set 5%-"
      ];

      # NOTE: you can use wev to see the keysym for a button
      #  (nix-shell -p wev)

      bindli =
        # media controls
        let
          # Only try the currently focused one
          # Otherwise it's gonna try everyone (in order) until it
          # finds an available one, which can be one that isn't focused.
          center = '', exec, playerctl --player="$(playerctl -l | head -n 1)" '';
        in [
          ",XF86AudioPrev${center}previous"
          ",XF86AudioNext${center}next"

          # this binds both play and pause to play-pause
          # since my headphones alternates which one it sends
          # if this is a problem (e.g you actually have and use
          # two specific play/pause buttons) then you might want
          # to change this
          ",XF86AudioPlay${center}play-pause"
          ",XF86AudioPause${center}play-pause"
        ];

      # kbd binds
      # NOTE: Submaps are ./submaps.nix since you have to use extraConfig at the moment
      bind = let
        mkArrowBind = mods: cmd: [
          "$mod ${mods}, H, ${cmd}, l"
          "$mod ${mods}, L, ${cmd}, r"
          "$mod ${mods}, K, ${cmd}, u"
          "$mod ${mods}, J, ${cmd}, d"
        ];

        mkScreenshotBind = let
          date = ''$(date "+%m-%d@%H:%M:%S")'';
          imgDir = "~/screenshots";
        in
          mods: cmd: [
            ''${mods}, PRINT, exec, mkdir -p ${imgDir}; grimblast --notify --freeze copysave ${cmd} ${imgDir}/${date}.png''
          ];
      in
        [
          "$mod, S, exec, $TERMINAL"
          "$mod, D, exec, rofi -show drun"
          "$mod, F, exec, $BROWSER"
          "$mod, Escape, exec, hyprlock --immediate --immediate-render"

          "$mod, C, killactive"
          "$mod, M, exit"

          "$mod, U, togglefloating"
          "$mod, I, fullscreen, 0" # entire display

          "$mod, P, exec, clr-pckr" # TODO: Make this similar to the other screenshot binds
        ]
        ++ (mkArrowBind "" "movefocus")
        ++ (mkArrowBind "CTRL" "movewindow")
        ++ (mkArrowBind "SHIFT" "swapwindow")
        ++ (mkScreenshotBind "" "area")
        ++ (mkScreenshotBind "CTRL" "screen")
        ++ (mkScreenshotBind "SHIFT" "output")
        ++ (
          builtins.concatLists (
            builtins.genList (
              x: let
                # number bind
                nb = toString (mod (x + 1) 10);

                # workspace name
                wn = toString (x + 1);
              in [
                # possibly bind $mod ALT to "goto monitor n"
                # go to workspace n
                # "$mod, ${nb}, workspace, ${wn}"

                # move active to workspace n, (preserve window focus)
                "$mod CTRL, ${nb}, movetoworkspace, ${wn}"

                # throw active to workspace n, (preserve workspace focus)
                "$mod ALT, ${nb}, movetoworkspacesilent, ${wn}"

                # switch current workspace with workspace n
                "$mod, ${nb}, focusworkspaceoncurrentmonitor, ${wn}"
              ]
            )
            10
          )
        );
    };
  };
}
