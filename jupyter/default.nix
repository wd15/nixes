# To use this environment use:
#
#     $ export NIXES=https://github.com/wd15/nixes/archive/refs/heads/master.zip
#     $ export NIXPKGS=export NIXPKGS=https://github.com/NixOS/nixpkgs/archive/21.05.tar.gz
#     $ nix-shell --pure -I nixpkgs=${NIXPKGS} -I nixes=${NIXES} -p 'python3Packages.callPackage <nixes/jupyter> {}'
#
# or to use in a subsequent derivation
#
#     jupyter_src = builtins.fetchTarball "https://github.com/wd15/nixes/archive/refs/heads/master.zip";
#     jupyter_extra = pypkgs.callPackage "${jupyter_src}/jupyter/default.nix";
#
# and then jupyter_extra can be used in buildInputs as part of a new derivation.
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
