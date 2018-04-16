{
  nixpkgs ? import (fetchTarball "https://github.com/NixOS/nixpkgs/archive/6f416dc5d360da59d12b34694a5cea8a99a2ed5f.tar.gz") {}
}:
nixpkgs.python36.withPackages (ps: with ps; [ ipython scipy ])
