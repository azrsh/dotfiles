#!/bin/bash
set -euo pipefail

CONFIGS=${@}
stow -v --no-folding -d ./config -t ${HOME} ${CONFIGS}

mkdir -p ./bin
stow -v --no-folding -d ./tool -t ./bin $(find ./tool/* -type d -exec basename {} \;)
echo "Please add '$(pwd)/bin' to \$PATH"
