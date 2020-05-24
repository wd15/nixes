{ pkgs ? (import (builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/20.03.tar.gz";
    sha256 = "0182ys095dfx02vl2a20j1hz92dx3mfgz2a6fhn31bqlp1wa8hlq";
  }) {}) }:
let
    pythonPackages = pkgs.python37Packages;
in
  pkgs.mkShell {
    buildInputs = with pythonPackages; [
      ipywidgets
      jupyter
      pip
      pandas
      numpy
    ];

    shellHook = ''
      jupyter nbextension install --py widgetsnbextension --user
      jupyter nbextension enable widgetsnbextension --user --py

      SOURCE_DATE_EPOCH=$(date +%s)
      export PYTHONUSERBASE=$PWD/.local
      export USER_SITE=`python -c "import site; print(site.USER_SITE)"`
      export PYTHONPATH=$PYTHONPATH:$USER_SITE
      export PATH=$PATH:$PYTHONUSERBASE/bin

      # To use pip after running nix-shell use
      #
      # pip install --user my_pkgs
      #
      # to install in .local

    '';
  }
