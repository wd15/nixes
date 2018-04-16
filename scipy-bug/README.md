# Environment to Demo a Scipy Bug

Nix expression to build a Python3.6 environement with Scipy and IPython.

# Usage

Follow the [Nix notes](../NIX-NOTES.md) for installing Nix. After
installing Nix and cloning this repository, run

    $ nix-env --switch-profile $NIX_USER_PROFILE_DIR/scipy-bug
    $ nix-env -if build.nix

or just

    $ nix-shell

## Help!

Read
[this](https://nixos.org/releases/tmp/release-nixos-unstable-small/nixos-18.03pre114662.a46f206271/unpack/nixos-18.03pre114662.a46f206271/doc/languages-frameworks/python.md)
to understand how Nix works with Python