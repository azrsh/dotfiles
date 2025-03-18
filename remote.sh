#!/bin/bash
set -euCo pipefail

BRANCH=${BRANCH:-"master"}

tmpdir="$(mktemp -d)"
git clone --recursive -b ${BRANCH} https://github.com/azrsh/dotfiles.git ${tmpdir}
cd ${tmpdir}

bash setup.sh -n
