#!/bin/bash

# This script activates the python virtual environment
# shellcheck disable=SC2086
# shellcheck source=/dev/null
source .venv/bin/activate

# Activate proper Nodejs Version via NVM
nvm use
