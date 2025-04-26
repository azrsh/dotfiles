#!/bin/bash
set -euCo pipefail

SHA=${SHA:-"master"}

tmpdir="$(mktemp -d)"
cd ${tmpdir}
git init
git remote add origin https://github.com/azrsh/dotfiles.git
git pull origin ${SHA}
git submodule update --init --recursive
cd ${tmpdir}

bash setup.sh -n
