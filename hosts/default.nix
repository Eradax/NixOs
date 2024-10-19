{
  self,
  withSystem, # has to be explicit since the module system is lazy
  ...
} @ args: let
  mkHosts = (import "${self}/parts/lib/mk_hosts.nix") ./. args;
  inherit (mkHosts) foldMapSystems mkSystem;
in {
  flake.nixosConfigurations = foldMapSystems mkSystem [
    {
      system = "x86_64-linux";
      name = "eradax-laptop";
    }
  ];
}
