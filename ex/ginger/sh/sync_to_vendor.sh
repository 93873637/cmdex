#!/bin/bash

# check if CMDEX_HOME set
# --------------------------------------------------------
if [ -z $CMDEX_HOME ]; then
    echo "ERROR: CMDEX_HOME not set"
    exit -1
fi
echo "CMDEX_HOME=$CMDEX_HOME"
# --------------------------------------------------------

# check if GINGER_HOME set
# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=$GINGER_HOME"
# --------------------------------------------------------

# ----------------------------------------------------
# Variable Settings

SRC_DIR=$CMDEX_HOME
TAR_DIR=/vendor/ginger_robot/install/share/cmdex_tools/scripts

# ----------------------------------------------------

source $CMDEX_HOME/sh/__ginger_utils.sh

sync_dir $SRC_DIR $TAR_DIR
