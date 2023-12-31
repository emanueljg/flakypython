{ pkgs, inputs, system, self' }: rec {
  checks.pre-commit-check = inputs.pre-commit-hooks.lib.${system}.run {
    src = ./.;
    hooks = {
      ${self'.formatter.pname} = { enable = true; };
      deadnix = { enable = true; };
      statix = { enable = true; };
    };
  };

  devShells.default = (pkgs.callPackage ../shell.nix { }).overrideAttrs {
    inherit (checks.pre-commit-check) shellHook;
  };
}
  
