#!/bin/bash

SRC_DIR=/home/kevin/work/nx441_dev/out/target/product/ginger-tx2/vendor/ginger_robot/install/lib
TAR_DIR=~/work/tmp

SHELL_DIR=$(dirname $BASH_SOURCE)
source $SHELL_DIR/__ginger_utils.sh
get_robot_vision_version $SRC_DIR $TAR_DIR
