# FiPy Nix Expression

Nix expression to install [FiPy](https://github.com/usnistgov/fipy) in
Python 3.

## Usage

Follow the [Nix notes](../NIX-NOTES.md) for installing Nix. After
installing Nix and cloning this repository, run

    $ nix-shell

in this directory. At that point, you should be able to run the FiPy
tests.

    $ python -c "import fipy; fipy.test()"

Currently, TVTK is not part of the installation so tests that require
TVTK are skipped.
