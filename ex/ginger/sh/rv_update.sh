#!/bin/bash

#
# PREREQUISITES:
# 1. using rv_get_*.sh to collect robot vison version files in source machine.
# 2. copy the folder to target CCU device.
# 3. make sure /vendor is writable on target CCU.
# 4. call this script to update with param of the folder's directory on target CCU.
#

if [ $# -ne 1 ]; then
    echo "Usage: `basename $0` <robot_vison-version-directory>"
    exit -1
fi

SRC_DIR=$1
TAR_DIR=/vendor/ginger_robot/install/lib

if [ ! -d $SRC_DIR ]; then
    echo "ERROR: source dir '$SRC_DIR' not found."
    exit -2
fi

if [ ! -d $TAR_DIR ]; then
    echo "ERROR: target dir '$TAR_DIR' not found."
    exit -3
fi

SRC_SO_FILE=$SRC_DIR/librobot_vision.so
SRC_NODE_FILE=$SRC_DIR/robot_vision_node

TAR_SO_FILE=$TAR_DIR/librobot_vision.so
TAR_NODE_FILE=$TAR_DIR/robot_vision/robot_vision_node

DATE=`date +%y.%m%d.%H%M%S`
TAR_BAK_DIR=~/tmp/rv_bak_$DATE
mkdir -p $TAR_BAK_DIR

echo
echo "** Original Files($TAR_DIR):"
ls -l $TAR_SO_FILE
ls -l $TAR_NODE_FILE

echo
echo "[UPDATE]: $SRC_SO_FILE -> $TAR_SO_FILE"
cp -rf $TAR_SO_FILE $TAR_BAK_DIR
cp -rf $SRC_SO_FILE $TAR_SO_FILE
echo "[UPDATE]: $SRC_NODE_FILE -> $TAR_NODE_FILE"
cp -rf $TAR_NODE_FILE $TAR_BAK_DIR
cp -rf $SRC_NODE_FILE $TAR_NODE_FILE
chmod +x /vendor/ginger_robot/install/lib/robot_vision/robot_vision_node

echo
echo "** Updated Files($TAR_DIR):"
ls -l $TAR_SO_FILE
ls -l $TAR_NODE_FILE

echo
echo "** Backup Files($TAR_BAK_DIR):"
ls -l $TAR_BAK_DIR

echo
