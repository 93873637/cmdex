#!/bin/bash

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
echo "SHELL_DIR=${SHELL_DIR}"

GINGER_HOME=../../../../..
echo "GINGER_HOME=${GINGER_HOME}"
mkdir -p $GINGER_HOME && cd $GINGER_HOME

BUILD_DIR=./build
if [ ! -d "$BUILD_DIR" ]; then
    mkdir $BUILD_DIR
fi
cd $BUILD_DIR

catkin_make --source ../src -DCATKIN_WHITELIST_PACKAGES="" -j6
if [ $? -ne 0 ]; then
    echo "catkin_make failed."
    exit -1
fi
cd ..
