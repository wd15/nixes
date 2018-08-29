{ nixpkgs ? import <nixpkgs {} }:
let
  nixpkgs = import <nixpkgs> {};
  hasktorch = nixpkgs.fetchFromGitHub {
    owner = "hasktorch";
    repo = "hasktorch";
    rev = "c67fae68b3739186c1539c049e7699deb2715b6d";
    sha256 = "0bpmisbgar9j1jsf7qlcka905p8kkv8hqsw67lszkbvqavd926dh";
  };
  aten = nixpkgs.fetchFromGitHub {
    owner = "hasktorch";
    repo = "ATen";
    rev = "e60f8c233bbb319c6b28ea530bc624d474a0b418";
    sha256 = "1myqmfwpbw2m0dwvi0251ngnbghlgz37b8z4hvvfj9wx3xdf7qyn";
  };
in
  nixpkgs.stdenv.mkDerivation rec {
    name = "aten";
    aten_src = aten;
    src = hasktorch;
    dontBuild = false;
    postUnpack = ''
      cp -r $aten_src/* $sourceRoot/vendor/aten
      find $sourceRoot/vendor -type d -exec chmod u+wx {} \;
      find $sourceRoot/vendor -type f -exec chmod u+w {} \;
    '';
    buildPhase = ''
      cd vendor
      ./build-aten.sh
    '';
    dontUseCmakeConfigure = true;
    installPhase = ''
      mkdir -p $out/lib
      echo $PWD
      cp -r ./aten/build/lib/* $out/lib/
    '';
    buildInputs = [
      nixpkgs.pkgs.cmake
      nixpkgs.python36
      nixpkgs.python36Packages.pyyaml
    ];
  }
