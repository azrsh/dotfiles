#!/bin/bash
set -euo pipefail

CONFIGS=${@}

stow -vD --no-folding -d ./config -t ${HOME} ${CONFIGS}
stow -vD -d ./tool -t ./bin $(find ./tool/* -type d -exec basename {} \;)
