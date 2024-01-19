#!/bin/bash

MODULE_NAME=robot_vision

# open and set dir to dump gstreamer dot file
GST_DOT_DIR=~/tmp
mkdir -p $GST_DOT_DIR
export GST_DEBUG_DUMP_DOT_DIR=$GST_DOT_DIR
echo "** GST_DEBUG_DUMP_DOT_DIR=[$GST_DEBUG_DUMP_DOT_DIR]"

rosservice call /robot_vision/ctrl "data: 'dot'"
if [ $? -ne 0 ]; then
    echo "ERROR: generate dot file failed."
    exit -1
fi

# cd the shell's dir
SHELL_DIR=`cd $(dirname $BASH_SOURCE) && pwd`
cd $SHELL_DIR

./dottmp.sh
