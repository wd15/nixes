with import <nixpkgs> { };

let jekyll_env = bundlerEnv rec {
    name = "jekyll_env";
    ruby = ruby_2_2;
    gemfile = ./Gemfile;
    lockfile = ./Gemfile.lock;
    gemset = ./gemset.nix;
  };
in
  stdenv.mkDerivation rec {
    name = "env";
    buildInputs = [
      jekyll_env
      python36
      python36.pkgs.numpy
      python36.pkgs.pylint
    ];
  }
