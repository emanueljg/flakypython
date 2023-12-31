{
  description = "Description for the project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
  };

  outputs = inputs @ { flake-parts, ... }:
    flake-parts.lib.mkFlake { inherit inputs; } {
      imports = [
      ];

      systems = [
        "x86_64-linux"
      ];

      perSystem =
        { config
        , self'
        , inputs'
        , pkgs
        , system
        , ...
        }: {
          formatter = pkgs.alejandra;
        };

      flake = {
        templates = {
          default = {
            path = ./default;
            description = "";
          };

          python = {
            path = ./python;
            description = "";
          };

          rust = {
            path = ./rust;
            description = "";
          };
        };
      };
    };
}
