#!/usr/bin/env sh

# Requires:
#
# - setup.sh
# - glibc/install.sh
# - miniconda3/install.sh
# - jupyter/install.sh
# - pandoc/install.sh
# - user/aportser.sh
# - aports/install.sh
# - texlive/build.sh
# - texlive/jupyter.sh

#
# Load required env variables: build is in OCI/ACI shell session
#
for f in /etc/profile.d/*; do source $f; done

apk add --virtual .build-dependencies --no-cache alpine-sdk

# Install all OS dependencies for fully functional notebook server
# texlive requires edge 
apk add --no-cache biber \
        emacs-nox \
        font-bakoma \
        git \
        inkscape \
        libsm \
        libxext-dev \
        libxrender \
        python3-dev \
        racktables \
        unzip \
        vim

# # Mapping Docker-Ubuntu \ Buildah-Alpine   
# #    build-essential \ alpine-sdk
# #    emacs \ emacs-nox
# #    git \ 
# #    inkscape \ inkscape
# #    jed \ vim
# #    libsm6 \ libsm
# #    libxext-dev \ libxext-dev
# #    libxrender1 \ libxrender
# #    lmodern \ font-bakoma
# #    netcat \ racktables
# #    pandoc \ ./pandoc/install.sh
# #    python-dev \ python3-dev
# #    texlive-fonts-extra \ texmf-dist-most
# #    texlive-fonts-recommended \ texmf-dist-most
# #    texlive-generic-recommended \ texmf-dist-most
# #    texlive-latex-base \ texmf-dist-most
# #    texlive-latex-extra \ texmf-dist-most
# #    texlive-xetex \ texlive-xetex
# #    unzip \ unzip
# #    vim \ vim