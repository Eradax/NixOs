# the "full-installer" should probably be a recovery thing
# or an iso for servers
{
  my_lib,
  inputs,
  lib,
  self,
  keys,
  ...
}: let
  inherit (my_lib.opt) enable;
in {
  imports = [
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/installation-cd-minimal.nix"
    "${inputs.nixpkgs}/nixos/modules/installer/cd-dvd/channel.nix"
    "${self}/modules/nixos/misc/iso.nix"
  ];

  config = {
    users.users.eradax = {
      isNormalUser = true;
      description = "eradax";

      extraGroups = ["networkmanager" "wheel" "libvirtd"];
      hashedPassword = "$y$j9T$0UbmymXnVP28DBFRi9PwD.$9PfNR/W2/viUhOQ8BKhADUJt.MZTPhRCuni6ufk1S/0"; # password = 0

      openssh.authorizedKeys.keys = [keys.users.eradax];
    };

    networking.wireless.enable = false;

    modules.nixos = {
      suites.all = enable;

      misc.iso =
        enable
        // {
          name = "full-install";
        };

      # collides with the installer stuff
      os.networking = {
        openssh.enable = lib.mkForce false; # does this really collide
      };
    };
  };
}
