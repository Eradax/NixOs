{
  config,
  lib,
  pkgs,
  ...
}: {
  imports = [
    # Include the results of the hardware scan.
    ./hardware.nix
  ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  users.users.upidapi = {
    isNormalUser = true;
    description = "upidapi";

    # make a cfg-editor group that makes it so that a user
    # can edit the config
    extraGroups = ["networkmanager" "wheel"];
    # shell = pkgs.zsh;
    initialPassword = "1";
    packages = with pkgs; [
      git
    ];
  };
  # services.xserver.enable = true;

  system.stateVersion = "24.05"; # Did you read the comment?

  # Set your time zone.
  time.timeZone = "Europe/Stockholm";

  # Select internationalisation properties.
  i18n = {
    defaultLocale = "en_GB.UTF-8";

    extraLocaleSettings = {
      LC_ADDRESS = "sv_SE.UTF-8";
      LC_IDENTIFICATION = "sv_SE.UTF-8";
      LC_MEASUREMENT = "sv_SE.UTF-8";
      LC_MONETARY = "sv_SE.UTF-8";
      LC_NAME = "sv_SE.UTF-8";
      LC_NUMERIC = "sv_SE.UTF-8";
      LC_PAPER = "sv_SE.UTF-8";
      LC_TELEPHONE = "sv_SE.UTF-8";
      LC_TIME = "sv_SE.UTF-8";
    };
  };

  # probably move the following to hardware/keyboard
  # Configure console keymap
  console.keyMap = "sv-latin1";
  # console.useXkbConfig = true;

  # Configure keymap
  # "xserver" is actually just the general display server
  # so this actually configs wayland too.
  services.xserver.xkb = {
    layout = "se";
    variant = "";

    # replace caps with esc, bc ... well fuck caps
    # this doen't work
    options = "caps:escape";
  };
}
/*
# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’).
# https://www.reddit.com/r/NixOS/comments/e3tn5t/reboot_after_rebuild_switch/
{
  # config,
  pkgs,
  # lib,
  # inputs,
  # inputs',
  # self,
  # self',
  my_lib,
  ...
}: let
  inherit (my_lib.opt) enable;
in {
  imports = [
    # Include the results of the hardware scan.
    # inputs.home-manager.nixosModules.default
    ./hardware.nix
  ];

  networking.hostName = "upidapi-nix-pc"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";

  # Enable networking

  networking.networkmanager.enable = true;

  # todo: put this somewhere else
  # this just makes the user own /persist/nixos
  systemd.tmpfiles.settings = {
    # i believe that that name is arbitrary (10-mypackage)
    "10-mypackage" = {
      "/persist/nixos" = {
        z = {
          group = "users";
          mode = "0755";
          user = "upidapi";
        };
      };
    };
  };

  environment.variables = {
    WLR_NO_HARDWARE_CURSORS = "1";
    LIBVA_DRIVER_NAME = "nvidia";
    XDG_SESSION_TYPE = "wayland";
    GBM_BACKEND = "nvidia-drm";
    # __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.upidapi = {
    isNormalUser = true;
    description = "upidapi";

    # make a cfg-editor group that makes it so that a user
    # can edit the config
    extraGroups = ["networkmanager" "wheel"];
    shell = pkgs.zsh;
    initialPassword = "1";
    # packages = with pkgs; [
    #   # firefox
    # ];
  };

  # user.user.root.initialPassword = "1";

  modules.nixos = {
    nix = {
      cfg-path = "/persist/nixos";

      cachix = enable;
      flakes = enable;
      gc = enable;
    };

    other = {
      sops = enable;
      impermanence = enable;
    };

    cli-apps = {
      less = enable;
      zsh = enable;
    };

    apps = {
      # nushell = enable;
      steam = enable;
    };

    system = {
      fonts = enable;
      boot = enable;
      env = enable;
      locale = enable;
    };

    desktop.sddm = enable;

    hardware = {
      cpu.amd = enable;
      gpu.nvidia = enable;

      bth = enable;
      sound = enable;
      keyboard = enable;
      monitors = [
        {
          name = "DVI-D-1";
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 0;
          y = 0;
          workspace = 1;
        }
        {
          name = "HDMI-A-1";
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 1920;
          y = 0;
          primary = true;
          workspace = 2;
        }
        {
          name = "HDMI-A-2";
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 3840;
          y = 0;
          workspace = 3;
        }
      ];
    };
  };
  # Allow unfree packages
  nixpkgs.config.allowUnfree = true;

  # Enable the OpenSSH daemon.
  # services.openssh.enable = true;

  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "23.11"; # Did you read the comment?
}
*/

