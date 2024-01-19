#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=rtsp_video_server
LUNCH_FILE=rvs_v4l2.launch
# --------------------------------------------------------

# --------------------------------------------------------
# echo BASH_SOURCE=$BASH_SOURCE

THIS_FILE=$(echo $(basename $BASH_SOURCE))
echo "THIS_FILE=$THIS_FILE"

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
echo "SHELL_DIR=${SHELL_DIR}"
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=${GINGER_HOME}"
cd $GINGER_HOME
# --------------------------------------------------------

export GST_DEBUG=*:2 #,realsensesrc:6,rsdemux:6
echo "[ $THIS_FILE ]: set GST_DEBUG=$GST_DEBUG"

# open and set dir to dump gstreamer dot file
GST_DOT_DIR=~/tmp
mkdir -p $GST_DOT_DIR
export GST_DEBUG_DUMP_DOT_DIR=$GST_DOT_DIR
echo "[ $THIS_FILE ]: set GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

unset DISPLAY

echo ""
echo "[ $THIS_FILE ]: launch $MODULE_NAME/$LUNCH_FILE on local machine..."
source ros_local.sh
source build/devel/setup.bash
roslaunch $MODULE_NAME $LUNCH_FILE debug:=true
