{
  config,
  pkgs,
  lib,
  my_lib,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.home.apps.anki;
in {
  options.modules.home.apps.anki = mkEnableOpt "Whether or not to enable anki.";

  config = mkIf cfg.enable {
    /*
    home.packages = let
      anki = pkgs.symlinkJoin {
        name = "anki";
        paths = [pkgs.anki];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/anki \
            --add-flags "-b ~/persist/anki/data"
        '';
      };
    in [
      anki
    ];
    */

    /*
    home.packages = [
      (pkgs.symlinkJoin {
        name = "anki";
        paths = [pkgs.anki];
        buildInputs = [pkgs.makeWrapper];
        postBuild = ''
          wrapProgram $out/bin/anki \
            --add-flags "-b ~/persist/anki/data"
        '';
      })
    ];
    */

    /*
    home.packages = [
      (pkgs.runCommand
        "anki"
        {
          buildInputs = [pkgs.makeWrapper];
        }
        ''
          mkdir $out
          ln -s ${pkgs.anki}/* $out
          rm $out/bin
          mkdir $out/bin
          ln -s ${pkgs.anki}/bin/* $out/bin
          rm $out/bin/anki
          makeWrapper ${pkgs.anki}/bin/anki $out/bin/anki \
            --add-flags "-b ~/persist/anki/data/"
        '')
    ];
    */

    home.packages = [
      (pkgs.anki.overrideAttrs (oldAttrs: {
        buildInputs = oldAttrs.buildInputs or [] ++ [pkgs.makeWrapper];
        postInstall =
          oldAttrs.postInstall
          or ""
          + ''
            wrapProgram $out/bin/anki \
              --add-flags "-t"
          '';
      }))
    ];
  };
}
