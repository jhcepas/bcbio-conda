#!/bin/bash
# Small script to automate building latest packages inside of a bare
# centos:centos5 container. Useful for building dependencies with C
# extensions.
set -e

rpm -Uvh http://dl.fedoraproject.org/pub/epel/5/x86_64/epel-release-5-4.noarch.rpm
yum install -y wget bzip2 git gcc gcc-c++ patch zlib-devel make gcc44 gcc44-c++
mkdir -p /tmp/bcbio-conda-build
# gcc 4.8 in /opt/rh/devtoolset-2/root/usr/bin
# or enable globally with scl enable devtoolset-2 bash
wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo
yum install -y devtoolset-2-gcc devtoolset-2-binutils devtoolset-2-gcc-c++

cd /tmp/bcbio-conda-build
wget http://repo.continuum.io/miniconda/Miniconda-latest-Linux-x86_64.sh
bash Miniconda-latest-Linux-x86_64.sh -b -p /tmp/bcbio-conda-build/anaconda
export PATH=/tmp/bcbio-conda-build/anaconda/bin:$PATH
conda install -y conda conda-build binstar pyyaml toolz jinja2

cd /tmp/bcbio-conda
python update_binstar_packages.py