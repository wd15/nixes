with import <nixpkgs> { };

let jekyll_env = bundlerEnv rec {
    name = "jekyll_env";
    ruby = ruby_2_2;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
  pypi2nix = import ./requirements.nix { inherit pkgs; };
  nbval = import ./nbval.nix;
in
  stdenv.mkDerivation rec {
    name = "env";
    buildInputs = [
      jekyll_env
      python36
      # python36Packages.jupyter
      python36Packages.pillow
      python36Packages.numpy
      python36Packages.toolz
      python36Packages.pytest
      python36Packages.bokeh
      python36Packages.matplotlib
      python36Packages.flake8
      python36Packages.pylint
      pypi2nix.packages."pykwalify"
      pypi2nix.packages."vega"
      pypi2nix.packages."progressbar2"
      nbval
    ];
  }
