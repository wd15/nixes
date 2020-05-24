let
  inherit (import <nixpkgs> {}) fetchFromGitHub;
  nixpkgs_download = fetchFromGitHub {
    owner = "NixOS";
    repo = "nixpkgs";
    rev = "793fc88dbe9c8f53b144fd970a3685f7b1dec729";
    sha256 = "04g53i02hrdfa6kcla5h1q3j50mx39fchva7z7l32pk699nla4hi"; #20.03-beta
 };
  pkgs = import nixpkgs_download {
    config = {
      allowUnfree = true;
      cudaSupport = true;
    };
  };
  pythonPackages = pkgs.python3Packages;
in
  pkgs.stdenv.mkDerivation rec {
    pname = "pytorch-play1";
    version = "0.1";
    nativeBuildInputs = with pythonPackages; [
      scipy
      numpy
      matplotlib
      jupyter
      tkinter
      toolz
      pylint
      flake8
      black
      ipywidgets
      pytorch
      torchvision
      pillow
      pkgs.cudatoolkit
      imageio
    ];
    src = null;
    ##src=builtins.filterSource (path: type: type != "directory" || baseNameOf path != ".git") ./.;
    shellHook = ''
      jupyter nbextension install --py widgetsnbextension --user > /dev/null 2>&1
      jupyter nbextension enable widgetsnbextension --user --py  > /dev/null 2>&1
      pip install jupyter_contrib_nbextensions --user > /dev/null 2>&1
      jupyter contrib nbextension install --user > /dev/null 2>&1
      jupyter nbextension enable spellchecker/main > /dev/null 2>&1

      export OMPI_MCA_plm_rsh_agent=/usr/bin/ssh

      SOURCE_DATE_EPOCH=$(date +%s)
      export PYTHONUSERBASE=$PWD/.local
      export USER_SITE=`python -c "import site; print(site.USER_SITE)"`
      export PYTHONPATH=$PYTHONPATH:$USER_SITE
      export PATH=$PATH:$PYTHONUSERBASE/bin

      export CUDAPATH="/usr/lib/x86_64-linux-gnu"
      export LD_PRELOAD=$CUDAPATH/libcuda.so.435.21:$CUDAPATH/libnvidia-fatbinaryloader.so.435.21:$CUDAPATH/libnvidia-ptxjitcompiler.so.435.21:$CUDAPATH/libnvidia-ml.so.435.21
      export NIX_SSL_CERT_FILE=/etc/ssl/certs/ca-certificates.crt

      # To install extra packages use
      #
      # $ pip install --user <package>

    '';
  }
