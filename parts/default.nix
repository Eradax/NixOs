{...}: {
  imports = [
    ./args.nix
    ./install
    ./iso-images.nix
    ./npins
    ./pkgs
    ./shells
    ./templates
  ];

  # ./lib and ./keys is imported in ./args.nix
  # (actually in ./lib/mk_hosts.nix for now)
}
