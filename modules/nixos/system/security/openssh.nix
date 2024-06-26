{
  lib,
  my_lib,
  config,
  ...
}: let
  inherit (lib) mkIf;
  inherit (my_lib.opt) mkEnableOpt;
  cfg = config.modules.nixos.system.security.openssh;
in {
  options.modules.nixos.system.security.openssh =
    mkEnableOpt "enable openssh to allow for remote ssh connections";

  config = mkIf cfg.enable {
    services.openssh.enable = true;
    /*
    services.openssh = {
      enable = true;
      ports = [22];
    };

    networking = {
      firewall = {
        allowedTCPPorts = [22];
      };
    };
      settings = {
        PasswordAuthentication = true;
        AllowUsers = null; # Allows all users by default. Can be [ "user1" "user2" ]
        UseDns = true;
        # "yes", "without-password", "prohibit-password", "forced-commands-only", "no"
        PermitRootLogin = "prohibit-password";
      };
    };


    services.fail2ban = {
      enable = true;
      ignoreIP = ["192.168.0.101"];

      maxretry = 10;
      bantime = "1m";
      bantime-increment = {
        enable = true;
        multipliers = "1 2 5 10 15 30 60 120 360 720";
        rndtime = "5m";
      };
    */
    /*
    jails = {
      DEFAULT.settings.findtime = "15m";

      sshd = lib.mkForce ''
        enabled = true
        mode = aggressive
        port = ${
          lib.strings.concatMapStringsSep
          ","
          toString
          config.services.openssh.ports
        }
      '';
    };
    */
  };
}
