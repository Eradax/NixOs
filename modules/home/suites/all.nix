{
  my_lib,
  config,
  lib,
  ...
}: let
  inherit (my_lib.opt) mkEnableOpt enable;
  inherit (lib) mkIf;
  cfg = config.modules.home.suites.all;
in {
  options.modules.home.suites.all =
    mkEnableOpt "enables everything except the hardware specific stuff";

  # TODO: split this into smaller parts
  # TODO: dont just enable it but use something like mkDefault
  #  so that a user can override a suite

  config = mkIf cfg.enable {
    modules.home = {
      other = enable;

      apps = {
        discord = enable;
        alacritty = enable;
        firefox = enable;
        bitwarden = enable;
        inkscape = enable;
        r2modman = enable;
        spotify = enable;
      };

      # TODO: probably refactor cli-apps/ into
      #  terminal/
      #    shells/
      #    extensions/
      #    tools/
      cli-apps = {
        keepassxc = enable;
        # nixvim = enable;
        # nushell = enable;
        nvf = enable;
        bat = enable;
        cn-bth = enable;
        direnv = enable;
        eza = enable;
        git = enable;
        gpg = enable;
        nix-index = enable;
        pandoc = enable;
        ssh = enable;
        tmux = enable;
        wine = enable;
        zsh = {
          enable = true;
          set-shell = true;
        };
      };

      services = {
        playerctl = enable;
      };

      misc = {
        dconf = enable;
        sops = enable;
        persist = enable;
        stylix = enable;
      };

      desktop = {
        wayland = enable;
        hyprland = enable;
        addons = {
          wallpaper.hyprpaper = enable;
          bar.ags = enable;
          dunst = enable;
          gtk = enable;
          rofi = enable;
          hyprlock = enable;
          hypridle = enable;
        };
      };
    };
  };
}
