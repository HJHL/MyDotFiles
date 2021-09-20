#!/usr/bin/env bash

USER_LOCAL=$HOME/.local
TYPE_OS=`uname`
TYPE_DIST=""
PREFIX=$USER_LOCAL
DEPS_BASE="curl git zip build-essential ninja-build"

function printHelp() {
    echo "Usage:"
}

function downloadFromGit() {
    if [ $# == 2 ]; then
        git clone --recursive --depth=1 $1 $2
    elif [ $# == 3 ]; then
        git clone --recursive --depth=1 $1 $2 --branch $3
    else
        echo "Usage: downloadFromGit REPO_URL DEST_DIR [TAG/Branch]"
    fi
}

function installNeovimFromSource() {
    echo "Install neovim from source...Start: `date`"
    START=$SECONDS
    URL="https://github.com/neovim/neovim.git"
    DEPS="gettext libtool libtool-bin autoconf automake cmake pkg-config"
    DOWNLOAD_DIR=/tmp/neovim.git
    sudo apt update
    sudo apt install $DEPS $DEPS_BASE -y
    downloadFromGit $URL $DOWNLOAD_DIR
    cd $DOWNLOAD_DIR
    cmake -B.deps -Hthird-party -GNinja && ninja -C .deps
    cmake -Bbuild -H. -GNinja -DCMAKE_BUILD_TYPE=RelWithDebInfo -DCMAKE_INSTALL_PREFIX=$PREFIX
    cmake --build build --target install
    END=$SECONDS
    DURATION=$(($END - $START))
    echo "Installed Neovim. End: `date`, duration: $((DURATION))s"
}

function installTmuxFromSource() {
    echo "Install tmux from source...Start: `date`"
    START=$SECONDS
    DEPS="automake autoconf pkgconf bison"
    URL="https://github.com/tmux/tmux.git"
    CUR_ENV="LDFLAGS=\"-L$HOME/.local/lib -L$HOME/.local/lib64\" CFLAGS=\"-I$HOME/.local/include\""
    URL_EVENT="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"
    URL_NCURSES="https://invisible-mirror.net/archives/ncurses/ncurses-6.2.tar.gz"
    URL_SSL="https://www.openssl.org/source/openssl-3.0.0.tar.gz"
    VERSION="3.3-rc"
    DOWNLOAD_DIR=/tmp/tmux.git
    sudo apt install $DEPS -y
    downloadFromGit $URL $DOWNLOAD_DIR $VERSION
    cd $DOWNLOAD_DIR
    mkdir .deps
    export LDFLAGS="-L$HOME/.local/lib -L$HOME/.local/lib64"
    export CFLAGS="-I$HOME/.local/include"
    export PKG_CONFIG_PATH=$HOME/.local/lib/pkgconfig
    curl -sSL $URL_SSL -o $(pwd)/.deps/openssl.tar.gz \
        && tar zxvf .deps/openssl.tar.gz -C .deps/ && cd .deps/openssl-3.0.0/ \
        && ./config --prefix=$PREFIX \
        && make -j && make install && cd ../../
    curl -sSL $URL_EVENT -o $(pwd)/.deps/libevent.tar.gz \
        && tar zxvf .deps/libevent.tar.gz -C .deps/ && cd .deps/libevent-2.1.12-stable/ \
        && ./configure --prefix=$PREFIX --enable-shared \
        && make -j && make install && cd ../../
    curl -sSL $URL_NCURSES -o $(pwd)/.deps/ncurses.tar.gz \
        && tar zxvf .deps/ncurses.tar.gz -C .deps/ && cd .deps/ncurses-6.2/ \
        && ./configure --prefix=$PREFIX --with-shared --with-termlib --enable-pc-files --with-pkg-config-libdir=$HOME/.local/lib/pkgconfig \
        && make -j && make install && cd ../../
    rm -rf $(pwd)/.deps/
    sh autogen.sh
    ./configure --prefix=$PREFIX && make install -j
    END=$SECONDS
    DURATION=$(($END - $START))
    echo "Installed Tmux. End: `date`, duration: $((DURATION))s"
}

#installTmuxFromSource

function checkEnv() {
    echo "Your home: $HOME"
    echo "Your local dir: $USER_LOCAL"
    echo "Your os type: $TYPE_OS"
    echo "Your distribution: "
}

if [ $# == 0 ]; then
    printHelp
    exit 1
elif [ $# == 1 ]; then
    checkEnv
    sudo apt update && sudo apt install $DEPS_BASE -y
    case $1 in
        "all") echo "Install all softwares..."
            ;;
        "neovim") installNeovimFromSource
            ;;
        "tmux") installTmuxFromSource
            ;;
    esac
fi
