# Play with pytorch

## Running on a remote server

Running the notebook on a remote server with a GPU via another server
that gives access to the GPU server. The problem is that the machine
with the GPU doesn't have any ports that can be seen from the outside
other than SSH. First setup port forwarding

    $ ssh ruth
    $ ssh -N -L ruth:8888:localhost:8888 gpu2

`rgpu2` seems to work with Nix.

Start up the notebook

    $ ssh ruth
    $ srun -N 1 -n 5 --pty --partition=gpu --gres=gpu:kepler:1 bash
    $ cd .../pytorch-play
    $ nix-shell --pure
    [nix-shell]$ cd ...
    [nix-shell]$ jupyter notebook --no-browser --NotebookApp.allow_remote_access=True

The `allow_remote_access` is required otherwise you get a 403. Copy
the token and you should be able to view the notebooks from
`http://ruth:8888/?token=<token>`.
