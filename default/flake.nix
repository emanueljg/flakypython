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
        { self'
        , pkgs
        , system
        , ...
        }:
        let pre-commit = import ./nix/pre-commit.nix { inherit pkgs inputs system self'; }; in {
          formatter = pkgs.nixpkgs-fmt;
          checks.pre-commit-check = pre-commit.checks.pre-commit-check;
          devShells.default = pkgs.callPackage ./shell.nix {
            inputsFrom = [
              pre-commit.devShells.default
            ];
          };
        };

      flake = { };
    };
}
