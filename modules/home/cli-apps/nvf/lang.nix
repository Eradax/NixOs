{
  config,
  lib,
  my_lib,
  inputs,
  pkgs,
  ...
}: let
  inherit (my_lib.opt) enable;
in {
  programs.nvf.settings.vim = {
    languages = {
      enableDAP = true;
      enableLSP = true;
      enableFormat = true;
      enableTreesitter = true;
      enableExtraDiagnostics = true;

      # TODO: add lang run

      markdown = enable;

      html = enable;
      css = enable;
      tailwind = enable;
      ts = enable; # also adds js support

      # TODO: nixd
      nix = enable;
      go = enable;
      python = enable;
      bash = enable;
      sql = enable;

      lua = {
        enable = true;
        lsp.neodev.enable = true;
      };

      rust = {
        enable = true;
        crates.enable = true;
      };

      clang = {
        enable = true;
        lsp = {
          enable = true;
          server = "clangd";
        };
      };
    };
  };
}