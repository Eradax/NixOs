{
  config,
  lib,
  my_lib,
  pkgs,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) enable;
  cfg = config.modules.home.cli-apps.nvf;
in {
  imports = [
    ## ./cmp.nix
    ./dap.nix
    ./lang.nix
  ];

  # TODO: various refactoring tools
  #  eg rope for python

  config = mkIf cfg.enable {
    # TODO: fix nix str escape highliting
    #  use :Inspect to inpect under cursor
    #  use :InspectTree to get tresitter output
    #  The problem is that the escape token color thingy is not in the
    #  semantic rokens but in the TreeSitter things
    /*
    Treesitter
    - @string.escape.nix links to @string.escape nix  # <== is here

    Semantic Tokens
    - @lsp.type.string.nix links to String priority: 125  # <== should be here
     - @lsp.type.string.nix links to String priority: 125
    - @lsp.mod.escape.nix links to @lsp priority: 126
    - @lsp.typemod.string.escape.nix links to @lsp priority: 127
    */

    # x = "asd//// \\ \" \\ \${gjkhg} "; y = "";
    home.packages = with pkgs; [
      nixd
      # nixfmt
      nixfmt-rfc-style
      nixpkgs-fmt

      fd # used by treesitter

      # for image nvim
      imagemagick
      curl # (Remote images)
      ueberzug
    ];

    programs.nvf = {
      settings.vim = {
        luaPackages = [
          "magick" # for image nvim
        ];

        startPlugins = with pkgs.vimPlugins; [
          (nvim-treesitter.withPlugins (
            parsers: builtins.attrValues {inherit (parsers) nix markdown markdown_inline;}
          ))
        ];

        dashboard = {
          # ? alpha = enable;
        };

        # git intergration
        # TODO: binds?
        git.vim-fugitive = enable;

        /*
        treesitter = {
          enable = true;
          autotagHtml = true;

          # show shat scopes you're in as horizontal lines
          # context = enable;

          # ? fold = true; (prob use nvim-ufo insted)

          # already set by lang.nix
          # grammars = []

          incrementalSelection = enable;
          indent = enable;

          mappings = {
            # TODO:
          };
        };
        */

        utility = {
          diffview-nvim = enable;

          images.image-nvim = {
            # doesn't work
            # enable = true;
            # setupOpts.backend = "ueberzug"; # TODO: "kitty"; ?
          };

          # prob not
          # motion.leap = enable;

          preview.markdownPreview = enable;

          # surround = enable;
        };
      };
    };
  };
}
