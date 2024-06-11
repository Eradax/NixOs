{
  # config,
  # pkgs,
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
  system.stateVersion = "23.11"; # Did you read the comment?

  # Define a user account. Don't forget to set a password with ‘passwd’.
  users.users.eradax = {
    isNormalUser = true;
    description = "eradax";

    extraGroups = ["networkmanager" "wheel" "libvirtd"];
    initialPassword = "1";
  };

  users.users.root.initialPassword = "1";

  modules.nixos = {
    host-name = "eradax-nix-laptop";

    suites.all = enable;

    hardware.monitors = [
      {
        name = "eDP-1";
        width = 1920;
        height = 1080;
        refreshRate = 60;
        x = 0;
        y = 0;
        workspace = 2;
      }
    ];
  };
}
