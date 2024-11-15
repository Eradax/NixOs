{
  config,
  lib,
  my_lib,
  pkgs,
  inputs',
  ...
}: let
  inherit (lib) mkIf mkOption types;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.discord;
in {
  options.modules.home.apps.discord =
    mkEnableOpt "Whether or not to enable discord."
    // {
      package = mkOption {
        type = types.package;
        # TODO: switch back to unstable vesktop when it works
        # default = pkgs.vesktop.override {
        default = inputs'.nixpkgs-stable.legacyPackages.vesktop.override {
          # withSystemVencord = false;
        };
      };

      finalPackage = mkOption {
        type = types.package;
        readOnly = true;
        default = cfg.package.overrideAttrs (old: {
          patches =
            (old.patches or [])
            ++ [
              ./fix-readonly.patch
              # ./remove-splash.patch
              # ./tray-notifications.patch
            ];

          pnpmDeps = old.pnpmDeps.overrideAttrs {
            outputHash = "sha256-rizJu6v04wFEpJtakC2tfPg/uylz7gAOzJiXvUwdDI4=";
          };
        });
      };
    };

  config = mkIf cfg.enable {
    home.packages = [
      cfg.finalPackage
    ];

    stylix.targets.vesktop.enable = false;

    xdg.configFile = {
      "vesktop/settings/settings.json".text = builtins.toJSON (
        (builtins.fromJSON (builtins.readFile ./vencord-config.json))
        // {
          notifyAboutUpdates = true;
          autoUpdate = false;
          autoUpdateNotification = true;
          useQuickCss = true;
          themeLinks = [
            # halfbroken tokyo night theme
            # "https://raw.githubusercontent.com/Dyzean/Tokyo-Night/main/themes/tokyo-night.theme.css"
          ];
          enabledThemes = [
            # custom theme
            "theme.css"
          ];
          enableReactDevtools = false;
          frameless = false;
          transparent = false;
          winCtrlQ = false;
          disableMinSize = false;
          winNativeTitleBar = false;
        }
      );

      "vesktop/themes/theme.css".text = builtins.readFile ./theme.css;

      "vesktop/settings.json".text = builtins.toJSON {
        arRPC = "on";
        discordBranch = "stable";
        hardwareAcceleration = false;
        minimizeToTray = "on";

        splashTheming = true;
        splashColor = config.stylix.base16Scheme.base07;
        splashBackground = config.stylix.base16Scheme.base01;

        tray = true;
        trayBadge = true;
      };
    };

    # vesktop schecks if state.json has the "firstLaunch" to
    # determine if it should show the "Welcome to vesktop" page
    home.activation = {
      # We have to do it like this since vesktop needs be able to
      # write to it (a symlink to the store would have been unwritabe)
      # If vesktop can't write to it then it chrashes
      createVesktiopStateJson = let
        state_path = "~/.config/vesktop/state.json";
        data = builtins.toJSON {
          # (the other setting dont matter)
          firstLaunch = false; # the value of this is ignored lol
        };
      in
        lib.hm.dag.entryAfter ["linkGeneration"] ''
          echo '${data}' > ${state_path}
        '';
    };
  };
}
