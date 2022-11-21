# /bin/bash

set -ex

export GOARCH=amd64 
scripts/build_flannel.sh

export GOARCH=arm64 
scripts/build_flannel.sh

export GOARCH=ppc64le 
scripts/build_flannel.sh