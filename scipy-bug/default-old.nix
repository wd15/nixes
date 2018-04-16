{
  nixpkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/c2df8a28eec869c0f6cf10811f8d3bbc65b6dfc0.tar.gz") {}
}:
import ./default.nix { inherit nixpkgs; }
