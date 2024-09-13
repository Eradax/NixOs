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
    # mkpasswd

    hashedPassword = "$y$j9T$d5vQf2yRUxO.fcgKRGkEh1$vgTjwslFwi6.tytTOtd/2uh7eZnXMhzHYbBAALeQM15";

    openssh.authorizedKeys.keys = [keys.users.eradax];
  };

  # users.users.root.initialPassword = "1";
  users.users.root.hashedPassword = "$y$j9T$d5vQf2yRUxO.fcgKRGkEh1$vgTjwslFwi6.tytTOtd/2uh7eZnXMhzHYbBAALeQM15";

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
