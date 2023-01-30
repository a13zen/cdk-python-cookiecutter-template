#!/bin/bash
set -e -o pipefail



echo "⭐ Setup Nodejs "
# shellcheck source=/dev/null
# shellcheck disable=SC2086
[[ -s $HOME/.nvm/nvm.sh ]] && . "$HOME/.nvm/nvm.sh"  # Load NVM
nvm use

echo "⭐ Creating python virtual environment "
python3 -m venv .venv
# shellcheck disable=SC2086
# shellcheck source=/dev/null
source .venv/bin/activate
which python3
pip install pip-tools
pip-compile

echo "⭐ Installing tools"
pip install pep8
pip install flake8
pip install black
pip install pre-commit
pip install cfn-lint
pip install commitizen

echo "⭐ Installing requirements"
pip install -r requirements.txt

echo "⭐ Setup git "
git init
git remote add origin "{{cookiecutter.git_repo_url}}"

echo "⭐ Installing pre-commit hook "
echo "NOTE: This requires sudo to run 'git defender --setup'"
# Needs to use git_defender to run this to fix incompatibility with core.hooksPath
# https://github.com/pre-commit/pre-commit/issues/1198
sudo git defender -v --precommit_tool_setup

# Need to run this to install commit-msg type hooks (not installed via git defender)
sudo git config --system --unset-all core.hookspath
pre-commit install --hook-type commit-msg
sudo git defender --install
pre-commit validate-config

echo "⭐ Run git defender"
echo "---------------------------------------------"
git defender --setup
echo "---------------------------------------------"
echo "⭐ Initial Commit using Commitizen"
git add -A
git commit -m "build: initial commit"
