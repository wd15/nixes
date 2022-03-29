# To use this environment use:
#
#     $ export JUPYTER=
#     $ export NIXPKGS=export NIXPKGS=https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz
#     $ nix-shell --pure -I nixpkgs=${NIXPKGS} -p 'python3Packages.callPackage <JUPYTER> {}'
#
# or to use in a subsequent derivation
#
#     jupyter_extra = pypkgs.callPackage ...
{
  fetchPypi,
  buildPythonPackage,
  ipython,
  ipykernel,
  traitlets,
  notebook,
  widgetsnbextension,
  pandas,
  mkShell,
  jupyterlab,
  ipywidgets,
  python3
}:
let
  itables = buildPythonPackage rec {
    pname = "itables";
    version = "0.4.6";

    src = fetchPypi {
      inherit pname version;
      sha256 = "sha256-XiLxeYHR8a3QqiyA+azC5O157XuRGvgb+exU1h7aAck=";
    };

    doCheck = false;

    propagatedBuildInputs = [ ipykernel pandas ];
  };
in
  python3.withPackages (ps: with ps; [
    ipython
    ipykernel
    traitlets
    notebook
    widgetsnbextension
    itables
    ipywidgets
    jupyterlab
  ])
