{
  description = "Environment for DT project";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-24.05";
    utils.url = "github:numtide/flake-utils";
    poetry2nix = {
      url = "github:nix-community/poetry2nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, utils, poetry2nix }: (utils.lib.eachSystem ["x86_64-linux" ] (system:
    let
      pkgs = import nixpkgs {
        inherit system;
        config.cudaSupport = true;
        config.allowUnfree = true;
        overlays = [
          poetry2nix.overlays.default
        ];
      };
      # pkgs = nixpkgs.legacyPackages.${system};
      # pypkgs = pkgs.python310Packages;

      pypkgs-build-requirements = {
        # hbreader = [ "setuptools" ];
      };

      p2n-overrides = pkgs.poetry2nix.defaultPoetryOverrides.extend (self: super:
        builtins.mapAttrs (package: build-requirements:
          (builtins.getAttr package super).overridePythonAttrs (old: {
            buildInputs = (old.buildInputs or [ ]) ++ (builtins.map (pkg: if builtins.isString pkg then builtins.getAttr pkg super else pkg) build-requirements);
          })
        ) pypkgs-build-requirements
      );

      args = {
        projectDir = ./.;
        preferWheels = true;
        overrides = p2n-overrides;
        python = pkgs.python312;
      };
      env1 = pkgs.poetry2nix.mkPoetryEnv args;
      env = env1.override (args: { ignoreCollisions = true; });
      app = pkgs.poetry2nix.mkPoetryApplication args;

      # ansys = pkgs.stdenv.mkDerivation rec {
      #   pname = "ansys";
      #   version = "19.4";

      #   src = builtins.fetchurl {
      #     url = "file://" + "/usr/local/ansys_inc/v194/ansys/bin/ansys194";
      #     # Use the hash of the file for verification
      #     sha256 = "";
      #   };
          
      #   buildPhase = ''
      #     cp ${src} $out
      #   '';

      #   installPhase = ''
      #     cp $out/ansys194 $out/ansys
      #   '';
      # };
    in
     rec {
       ## See https://github.com/nix-community/poetry2nix/issues/1433
       ## It seems like poetry2nix does not seem to install as dev
       ## environment
       ## devShells.default = env.env;
       devShells.default = pkgs.mkShell {
         packages = [ env ];
         shellHook = ''
            export PYTHONPATH=$PWD
         '';
       };
       packages.amdt = app;
       packages.default = self.packages.${system}.amdt;
      }
    )
  );
}
