#!/bin/bash
set -e -o pipefail

echo "Setup Nodejs"
# shellcheck source=/dev/null
# shellcheck disable=SC2086
[[ -s $HOME/.nvm/nvm.sh ]] && . "$HOME/.nvm/nvm.sh"  # Load NVM
nvm use

echo "Creating python virtual environment"
python3 -m venv .venv
# shellcheck disable=SC2086
# shellcheck source=/dev/null
source .venv/bin/activate
which python3
pip install pip-tools
pip-compile

echo "Installing tools"
pip install pep8
pip install flake8
pip install black
pip install pre-commit
pip install cfn-lint
pip install commitizen

echo "Installing requirements"
pip install -r requirements.txt

echo "Setup git"
git init
git remote add origin "{{cookiecutter.empty_codecommit_repo_https_grc_clone_url}}"

echo "Installing pre-commit hooks"
echo "NOTE: This requires sudo to run 'git defender --precommit_tool_setup'"
# Needs to use git_defender to run this to fix incompatibility with core.hooksPath
# https://github.com/pre-commit/pre-commit/issues/1198
sudo git defender --precommit_tool_setup -v
pre-commit install-hooks

echo "Run git defender"
git defender --setup

echo "Initial Commit using Commitizen"
git add -A
git commit -m "build: initial commit"
