From ubuntu:16.04

MAINTAINER Daniel Wheeler <daniel.wheeler2@gmail.com>

ENV DEBIAN_FRONTEND noninteractive

USER root

RUN apt-get -y update
RUN apt-get install -y git && apt-get clean
RUN apt-get install -y sudo && apt-get clean
RUN apt-get install -y bzip2 && apt-get clean
RUN apt-get install -y curl && apt-get clean
RUN apt-get -y update

RUN useradd -m -s /bin/bash main
RUN echo "main:main" | chpasswd
RUN adduser main sudo

EXPOSE 8888

USER main

ENV HOME /home/main
ENV SHELL /bin/bash
ENV USER main
WORKDIR $HOME

USER root

RUN chown -R main:main /home/main
RUN echo "main ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers
RUN mkdir /etc/nix
RUN echo "build-users-group =" > /etc/nix/nix.conf

USER main

## Install Nix

RUN curl https://nixos.org/nix/install > ./install.sh
RUN bash ./install.sh
# RUN sudo chmod 1777 /nix/var/nix/profiles/per-user
# RUN sudo mkdir -m 1777 -p /nix/var/nix/gcroots/per-user
# RUN sudo chmod 1777 /nix/var/nix/gcroots/per-user
# RUN sudo chmod 1777 /home/main/.nix-defexpr
RUN cp /nix/var/nix/profiles/default/etc/profile.d/nix.sh ~/nix.sh
RUN chmod +w ~/nix.sh
RUN echo "unset PATH" | cat - ~/nix.sh > temp && mv temp ~/nix.sh
# RUN echo -e "unset PATH\n$(cat ~/nix.sh)" > ~/nix.sh
RUN echo "export PATH=\$PATH:/nix/var/nix/profiles/default/bin:/bin:/usr/bin" >> ~/nix.sh
RUN echo "export NIX_USER_PROFILE_DIR=/nix/var/nix/profiles/per-user/\$USER " >> ~/nix.sh


ENV SHELL /bin/bash

# ENV ANACONDAPATH $HOME/anaconda
# ENV PATH "$ANACONDAPATH/bin:${PATH}"

# RUN wget https://repo.continuum.io/miniconda/Miniconda2-4.3.11-Linux-x86_64.sh
# RUN bash Miniconda2-4.3.11-Linux-x86_64.sh -b -p $ANACONDAPATH
# RUN conda update conda
# RUN conda install libgfortran=1.0 && conda clean --all
# RUN conda install matplotlib && conda clean --all
# RUN conda install --channel guyer scipy gmsh && conda clean --all
# RUN conda install --channel guyer pysparse openmpi mpi4py && conda clean --all
# RUN conda install --channel guyer trilinos && conda clean --all

# ENV PIP "pip --no-cache-dir"

# RUN $PIP install scikit-fmm

# RUN git config --global user.name "Main"
# RUN git config --global user.email "main@main.com"

# ## Install FiPy

# RUN git clone https://github.com/usnistgov/fipy
# WORKDIR $HOME/fipy
# RUN git checkout ecbe868f2aff6dbc43fb8ed532e581a03ebab5d5
# RUN python setup.py develop

# ## Install Jupyter

# WORKDIR $HOME
# RUN conda install jupyter=1.0.0 && conda clean --all

# ## Setup

# EXPOSE 8888

# ENV SHELL /bin/bash