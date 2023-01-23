#!/bin/bash

PYTHON_VERSION={{cookiecutter.python_version}}
NODE_VERSION={{cookiecutter.node_version}}
CDK_VERSION={{cookiecutter.cdk_version}}

function check_tool_installed () {
    echo "Checking if $1 is installed:"
    if ! command -v $1 &> /dev/null
    then
        echo "❌ $1 could not be found. Please install it manually and try again"
        exit 1
    else
        echo "✅ $1 found"
    fi
}

[[ -s $HOME/.nvm/nvm.sh ]] && . $HOME/.nvm/nvm.sh  # Load NVM
echo "⭐ Checking Prerequisite tooling"
check_tool_installed git
check_tool_installed nvm

# load tools
echo "⭐ Installing node & cdk"
echo "Note: You might need to disconnect from the VPN to install this."
nvm install $NODE_VERSION
nvm use $NODE_VERSION
npm i -g aws-cdk@$CDK_VERSION 
npm i -g commit-and-tag-version

echo "⭐ Checking python version"
if [[ "$(python3 -V)" =~ "Python $PYTHON_VERSION" ]]; then
 echo "✅ Python $PYTHON_VERSION is installed"
else
 echo "❌ Incorrect python version. Please install python $PYTHON_VERSION using pyenv or similar and activate that version"
 echo "https://github.com/pyenv/pyenv"
 exit 1
fi
