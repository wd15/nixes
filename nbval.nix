{}:
let
  python = import ./requirements.nix { inherit pkgs; };
in python.mkDerivation {
  name = "nbval-4.7.0";
  src = pkgs.fetchurl { url = "https://pypi.python.org/packages/cc/a8/1fb1a6a08c1016204cfa747f44de1e405fc5968ae075068a654d633164ab/ipykernel-4.7.0.tar.gz"; md5 = "2d597192656fbac76c3c1a95aa18c44e" }

  buildInputs = [
    python36Packages.jupyter
    python.packages."pytest"
    python.packages."six"
    python.packages."jupyter_client"
    python.packages."nbformat"
    python.packages."coverage"
  ];
  propagatedBuildInputs = [
    python.packages."aiohttp"
    python.packages."arrow"
    python.packages."defusedxml"
    python.packages."frozendict"
    python.packages."jsonschema"
    python.packages."taskcluster"
    python.packages."virtualenv"
  ];
}
