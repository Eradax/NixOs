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
          withSystemVencord = false;
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

  # TODO: change the startup gif, currently not possible but there is
  #  a pr that will change that

  config = mkIf cfg.enable {
    home.packages = [
      cfg.finalPackage
    ];
  };
}
