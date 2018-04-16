# Install IHaskell (Haskell in the Jupyter Notebook)

A nix expression to install
[IHaskell][IHaskell].

## Install

Follow the [Nix notes](../NIX-NOTES.md) for installing Nix. After
installing Nix and cloning this repository, run

    $ nix-env -if default.nix

in this directory. This will install [IHaskell][IHaskell] in your
local profile.

## Usage

Run

    $ ihaskell-notebook

to launch the notebook with a Haskell capability.

[IHaskell]: https://github.com/gibiansky/IHaskell