{
  # config,
  # pkgs,
  # lib,
  # inputs,
  # inputs',
  # self,
  # self',
  keys,
  my_lib,
  ...
}: let
  inherit (my_lib.opt) enable;
in {
  system.stateVersion = "23.11"; # Did you read the comment?

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eradax = {
    isNormalUser = true;
    description = "eradax";

    extraGroups = ["networkmanager" "wheel" "libvirtd" "docker"];
    # initialPassword = "1";
    hashedPassword = "$y$j9T$eN4aMyABUwlAe94/yFBri.$RNICgTSgxA/qEJ/LSY.S/vDxDFYruKWODx7sdtOqVIC";

    openssh.authorizedKeys.keys = [keys.users.eradax];
  };

  # users.users.root.initialPassword = "1";
  users.users.root.hashedPassword = "$y$j9T$7fnSc3epJcVjpC4tnTRM90$OCZo/oEFj.XBIt9.W2gl7NqYMWfzQG.pWJ2jielys86";

  modules.nixos = {
    suites.all = enable;

    hardware = {
      cpu.amd = enable;
      # TODO: gpu.amd = enable;

      monitors.monitors = {
        "eDP-1" = {
          width = 1920;
          height = 1080;
          refreshRate = 60;
          x = 0;
          y = 0;
          workspace = 1;
          primary = true;
        };
      };
    };
  };
}
