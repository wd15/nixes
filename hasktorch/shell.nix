let
  nixpkgs = import <nixpkgs> {};
  aten = import ./aten.nix { inherit nixpkgs; };
  hasktorch = nixpkgs.fetchFromGitHub {
    owner = "hasktorch";
    repo = "hasktorch";
    rev = "c67fae68b3739186c1539c049e7699deb2715b6d";
    sha256 = "0bpmisbgar9j1jsf7qlcka905p8kkv8hqsw67lszkbvqavd926dh";
  };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "hasktorch";
    aten_src = aten;
    src = hasktorch;
    env = nixpkgs.buildEnv { name=name; paths=buildInputs; };
    buildInputs = [
      nixpkgs.haskellPackages.cabal2nix
      nixpkgs.haskellPackages.cabal-install
      nixpkgs.ghc
      nixpkgs.zlib
      aten
      nixpkgs.gd
      nixpkgs.fontconfig
      nixpkgs.freetype
      nixpkgs.expat
    ];
    shellHook = ''
      \rm -rf ./source
      unpackPhase
      cd ./source
      cabal new-build all --flags=-cuda
    '';
  }
