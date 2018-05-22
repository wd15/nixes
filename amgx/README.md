# PyAMGX Nix Expression

Nix expression for PyAMGX. 

## Install Nix

Follow the [Nix instructions for getting started with
Nix](https://nixos.org/nix/manual/#chap-quick-start).

## Update `shell.nix`

Change the following line in `shell.nix` to point at the correct CUDA
drivers.

```
export LD_PRELOAD="/usr/lib/x86_64-linux-gnu/libcuda.so /usr/lib/nvidia-384/libnvidia-fatbinaryloader.so.384.111";
```

## Use PyAMGX in nix-shell

In this directory, simply run

    $ nix-shell

and test with

    $ python demo.py

`shell.nix` can be amended to add more Python libraries.
