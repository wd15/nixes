with import <nixpkgs> { };

let
  hello = 1;
  pypi2nix = import ./requirements.nix { inherit pkgs; };
in
  pypi2nix.mkDerivation {
  name = "nbval-4.7.0";
  src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cc/a8/1fb1a6a08c1016204cfa747f44de1e405fc5968ae075068a654d633164ab/ipykernel-4.7.0.tar.gz"; sha256 = "354986612a38f0555c43d5af2425e2a67506b63b313a0325e38904003b9d977b"; };

  buildInputs = [
    python36Packages.ipython
    python36Packages.jupyter_client
    python36Packages.tornado
    python36Packages.nose
    python36Packages.matplotlib
  ];

}
