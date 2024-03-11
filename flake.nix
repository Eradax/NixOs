{
  description = "Nixos config flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    /*
       nur = {
      url = "github:nix-community/NUR";
    };
    */

    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nixvim = {
      url = "github:nix-community/nixvim";
      # If you are not running an unstable channel of nixpkgs, select the corresponding branch of nixvim.
      # url = "github:nix-community/nixvim/nixos-23.05";

      inputs.nixpkgs.follows = "nixpkgs";
    };

    alejandra = {
      url = "github:kamadorueda/alejandra/3.0.0";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = {
    self,
    nixpkgs,
    ...
  } @ inputs: let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system};
    # rootPath = ./.;
  in {
    nixosConfigurations.default = nixpkgs.lib.nixosSystem {
      specialArgs = {
        inherit inputs;
      };
      modules = [
        # note: modules are not added unless added to git
        # https://discourse.nixos.org/t/error-no-such-file-or-directory-when-trying-to-add-new-modules/31986/3
        ./hosts/default/config.nix
        inputs.home-manager.nixosModules.default
	      ({...}@data: (builtins.trace (pkgs.lib.attrNames data) ""))
      ];
    };
  };
}
