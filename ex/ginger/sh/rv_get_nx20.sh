#!/bin/bash

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "** GINGER_HOME = $GINGER_HOME"
# --------------------------------------------------------

SRC_DIR=$GINGER_HOME/build/devel/lib
TAR_DIR=~/work/tmp

SHELL_DIR=$(dirname $BASH_SOURCE)
source $SHELL_DIR/__ginger_utils.sh
get_robot_vision_version $SRC_DIR $TAR_DIR
