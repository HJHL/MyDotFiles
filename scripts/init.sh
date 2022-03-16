#!/bin/sh

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[0;33m'
NC='\033[0;0m'

ZSH_CUSTOM_CONFIG='$HOME/.zsh_ext_rc'
SCRIPT=`readlink -f "$0"`
PROJ="$(dirname "$SCRIPT")/.."
USER_CONFIG_PATH="$HOME/.config"

loge()
{
    echo "${RED}[ERROR] `date` $1 ${NC}"
}

logw()
{
    echo "${YELLOW}[WARN ] `date` $1 ${NC}"
}

logi()
{
    echo "${GREEN}[INFO ] `date` $1 ${NC}"
}

logi "Update and upgrade system..."
apt update && apt upgrade -y

logi "Install required softwares"
apt install curl zsh git build-essential nload htop -y

# zsh
if [ ! -d "$HOME/.oh-my-zsh" ]; then
    logi "Install oh-my-zsh..."
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    ln -s $PROJ/zsh/zsh_ext_rc $ZSH_CUSTOM_CONFIG
    if [ -f "$ZSH_CUSTOM_CONFIG" ]; then
        source $ZSH_CUSTOM_CONFIG
    fi
else
    logi "oh-my-zsh already installed"
fi

if [ ! -d "$USER_CONFIG_PATH" ]; then
    mkdir -pv $USER_CONFIG_PATH
fi

# nvim
if [ ! -d "$USER_CONFIG_PATH/nvim" ]; then
    ln -s $PROJ/nvim $USER_CONFIG_PATH/nvim
fi

if [ ! -d "$HOME/.nvm" ]; then
    logi "Install nvm..."
    curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
fi

if [ ! -x "$(command -v npm)" ]; then
    logi "Install npm neovim package..."
    npm install -g neovim
fi

if [ ! -x "$(command -v pip3)" ]; then
    curl -o- https://bootstrap.pypa.io/get-pip.py | python3
fi

if [ -x "$(command -v pip3)" ]; then
    pip3 install neovim
fi

#if [ ! -x "$(command -v node)" ]; then
#    logi "Install node..."
#    source "$HOME/.bashrc"
#    if [ ! -x $(command -v nvm) ]; then
#        loge "nvm node installed, pls check!"
#    else
#        nvm install node
#    fi
#fi
