#!/bin/bash

SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR = $SHELL_DIR"

source $SHELL_DIR/__ginger_utils.sh
check_ros
if [ $? -ne 0 ]; then
    echo "ERROR: check ros failed."
    exit -1
fi

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -2
fi
echo "** GINGER_HOME = $GINGER_HOME"
# --------------------------------------------------------

cd $GINGER_HOME

echo ""
if [ $# -eq 0 ]; then
    echo "Usage: "
    echo "$0 module_name"
    exit
fi
MODULE_NAME=$1
echo "[BO]: get module name: $MODULE_NAME"

BUILD_DIR=./build
if [ ! -d "$BUILD_DIR" ]; then
    mkdir $BUILD_DIR
fi
cd $BUILD_DIR

echo ""
echo "[BO]: build module $MODULE_NAME only..."
WHITELIST_PACKAGES="$MODULE_NAME"
BEGIN_TIME=$(date +%s.%N)
catkin_make --source ../src -DCATKIN_WHITELIST_PACKAGES=$WHITELIST_PACKAGES -j6
if [ $? -ne 0 ]; then
    echo "[BO]: catkin_make $MODULE_NAME failed."
    exit -1
fi
END_TIME=$(date +%s.%N)
TIME_USED=$(calculate_time_diff $BEGIN_TIME $END_TIME)
echo
echo "[BO]: build module $MODULE_NAME success, time used: ${TIME_USED}s"

cd ..
