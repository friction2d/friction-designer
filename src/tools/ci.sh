#!/bin/bash

set -e -x

CI=${CI:-0}
APT=${APT:-0}
PC=${PC:-""}

if [ "${APT}" = 1 ]; then
sudo apt update -y
sudo apt install -y \
curl \
git \
clang \
build-essential \
cmake \
python3 \
ninja-build \
libfontconfig1-dev \
libfreetype-dev \
libavcodec-dev \
libavformat-dev \
libavutil-dev \
libqscintilla2-qt5-dev \
libquazip1-qt5-dev \
libqt5opengl5-dev \
libqt5svg5-dev \
libswresample-dev \
libswscale-dev \
libunwind-dev \
qtbase5-dev-tools \
qtbase5-dev \
qtdeclarative5-dev-tools \
qtdeclarative5-dev \
qtmultimedia5-dev \
qttools5-dev-tools \
libexpat1-dev \
libfreetype-dev \
libjpeg-turbo8-dev \
libpng-dev \
libwebp-dev \
zlib1g-dev \
libicu-dev \
libharfbuzz-dev
fi

if [ "${CI}" = 1 ]; then
    git submodule update -i --recursive
fi

if [ "${PC}" != "" ]; then
    export PKG_CONFIG_PATH="${PC}:${PKG_CONFIG_PATH}"
fi

CWD=`pwd`
MKJOBS=${MKJOBS:-4}
COMMIT=`git rev-parse --short=8 HEAD`
BRANCH=`git rev-parse --abbrev-ref HEAD`

if [ "${BRANCH}" = "main" ]; then
    BRANCH=""
fi

cd ${CWD}
rm -rf build-ci || true
mkdir build-ci
cd build-ci

cmake -G Ninja \
-DCMAKE_BUILD_TYPE=Release \
-DCMAKE_INSTALL_PREFIX=/usr \
-DCMAKE_CXX_COMPILER=clang++ \
-DCMAKE_C_COMPILER=clang \
-DGIT_COMMIT=${COMMIT} \
-DGIT_BRANCH=${BRANCH} \
..
cmake --build .
