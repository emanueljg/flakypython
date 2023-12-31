{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-23.11";

    pre-commit-hooks = {
      url = "github:cachix/pre-commit-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];

      systems = import ./nix/systems.nix;

      perSystem =
        { config
        , self'
        , inputs'
        , pkgs
        , system
        , ...
        }: {
          formatter = pkgs.nixpkgs-fmt;
          devShells.default = pkgs.callPackage ./shell.nix { };
        } // (import ./nix/pre-commit.nix { inherit pkgs inputs system self'; });

      flake = { };
    };
}
