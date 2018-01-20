with import <nixpkgs> { };

let jekyll_env = bundlerEnv rec {
    name = "jekyll_env";
    ruby = ruby_2_2;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
  python = import ./requirements.nix { inherit pkgs; };
in
  stdenv.mkDerivation rec {
    name = "env";
    buildInputs = [
      jekyll_env
      python36
      python36.pkgs.numpy
      python36.pkgs.pylint
      python36Packages.numpy
      python36Packages.jupyter
      python36Packages.pillow
      python36Packages.numpy
      python36Packages.toolz
      python36Packages.pytest
      python36Packages.bokeh
      python36Packages.matplotlib
      python36Packages.flake8
      python.packages."progressbar2"
      python.packages."pykwalify"
      python.packages."pylint"
      python.packages."vega"
    ];
  }
