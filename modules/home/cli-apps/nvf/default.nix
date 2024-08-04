# 95% of this file is directly copied from raf / NotAShelf
{
  config,
  inputs,
  lib,
  my_lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;

  inherit (builtins) filter map toString path;
  inherit (lib.filesystem) listFilesRecursive;
  inherit (lib.strings) hasSuffix fileContents;
  inherit (lib.attrsets) genAttrs;

  inherit (inputs.nvf.lib.nvim.dag) entryBefore;

  mkRuntimeDir = name: let
    finalPath = ./runtime + /${name};
  in
    path {
      name = "nvim-runtime-${name}";
      path = toString finalPath;
    };

  cfg = config.modules.home.cli-apps.nvf;
in {
  imports = [
    inputs.nvf.homeManagerModules.default
    ./config
  ];

  options.modules.home.cli-apps.nvf =
    mkEnableOpt "enables nvf a neovim distro powerd by nix";

  config = mkIf cfg.enable {
    programs.nvf = {
      enable = true;
      enableManpages = true;
      defaultEditor = true;

      settings.vim = {
        package = pkgs.neovim-unwrapped;

        viAlias = false;
        vimAlias = false;

        # vim.globals can be used to set vim.g.<name>

        # defaults
        withNodeJs = false;
        withPython3 = false;
        withRuby = false;

        preventJunkFiles = true;
        useSystemClipboard = true;

        enableLuaLoader = true;
        enableEditorconfig = true;

        debugMode = {
          enable = false;
          level = 16;
          logFile = "/tmp/nvim.log";
        };

        # sv.utf-8.spl

        additionalRuntimePaths = [
          # (mkRuntimeDir "after")
          # (mkRuntimeDir "spell")
          (path {
            name = "nvim-runtime";
            path = toString ./runtime;
          })
        ];

        # notashelf
        # additional lua configuration that I can append or, to be more
        # precise, randomly inject into the lua configuration of my Neovim
        # configuration wrapper. This is recursively read from the lua
        # directory, so we do not need to use require
        luaConfigRC = let
          spellFile = path {
            name = "nvf-en.utf-8.add";
            path = ./runtime/spell/en.utf-8.add;
          };

          # get the name of each lua file in the lua directory, where setting
          # files reside and import them recursively
          configPaths =
            filter
            (hasSuffix ".lua")
            (map toString (listFilesRecursive ./lua));

          # generates a key-value pair that looks roughly as follows:
          #  `<filePath> = entryAnywhere ''<contents of filePath>''`
          # which is expected by nvf's modified DAG library
          luaConfig = genAttrs configPaths (file:
            entryBefore ["luaScript"] ''
              ${fileContents file}
            '');
        in
          luaConfig // {spell = "vim.o.spellfile = \"${spellFile}\"";};
      };
    };
  };
}
