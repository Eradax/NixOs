{lib, ...}: let
  inherit (builtins) elem;
  inherit (lib.attrsets) filterAttrs;

  # Users
  users = {
    admin = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK0MLLzh+8UzScYKSVSN0j0su890AhlfWNz8Lz3lQ0tl admin";

    eradax = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIK/yw30FU+G07WduzsZCsPKbi2wYrdgRaHFMZ3ccunaK eradax@eradax-laptop";
  };

  # Hosts
  machines = {
    full-installer-x86_64 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIDf1kXG1cPMYLKvV7EgOrfGax4IyR4aCQW7Y+7vA1AMp root@full-installer-x86_64";
    minimal-installer-x86_64 = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIvANBIwQX5DD5J5ymR5LJ9aqbDC0h17OmGjbvZqY2Iq root@minimal-installer-x86_64
";
  };

  filterAttrsList = inp: white_list: (filterAttrs (x: elem white_list x) inp);
  # Shorthand aliases for various collections of host keys

  servers = filterAttrsList machines [];
  workstations = filterAttrsList machines [
    "eradax-laptop"
  ];
  # all = (attrValues users) ++ (attrValues machines);
in {
  inherit
    users
    machines
    servers
    workstations
    ;
  # all
}
