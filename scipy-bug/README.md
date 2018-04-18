# Environment to Demo a Scipy Bug

Nix expression to build a Python3.6 environment with Scipy and IPython.

# Usage

Follow the [Nix notes](../NIX-NOTES.md) for installing Nix. After
installing Nix and cloning this repository, run

    $ nix-env --switch-profile $NIX_USER_PROFILE_DIR/scipy-bug
    $ nix-env -if build.nix

or just

    $ nix-shell

and then run

    $ python bug.py

to see the bug for version 1.0.1. To see the version without the bug use

    $ nix-shell default-old.nix

and then run

    $ python bug.py

## Help!

Read
[this](https://nixos.org/releases/tmp/release-nixos-unstable-small/nixos-18.03pre114662.a46f206271/unpack/nixos-18.03pre114662.a46f206271/doc/languages-frameworks/python.md)
to understand how Nix works with Python