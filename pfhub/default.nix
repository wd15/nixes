let
  nixpkgs = import ./nixpkgs_version.nix;
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "pfhub";
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      ( import ./build.nix { inherit nixpkgs; })
    ];
  }
