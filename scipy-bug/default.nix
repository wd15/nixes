{
  nixpkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6f416dc5d360da59d12b34694a5cea8a99a2ed5f.tar.gz") {}
}:
nixpkgs.stdenv.mkDerivation {
  name = "my-env";
  buildInputs = [
    ( import ./build.nix { inherit nixpkgs; })
  ];
}
