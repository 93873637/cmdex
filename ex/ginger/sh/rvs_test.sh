#!/bin/bash

# --------------------------------------------------------
MODULE_NAME=rtsp_video_server
HELP_OPT=-h

SERVICE_PORT_OPT=-p
SERVICE_PORT=33800 # default value

MOUNT_POINT_OPT=-m
MOUNT_POINT=/test # default value

LAUNCH_STR_OPT=-l

# LAUNCH_STR_TEST="videotestsrc ! video/x-raw,width=352,height=288,framerate=15/1 ! x264enc ! rtph264pay name=pay0 pt=96"
# LAUNCH_STR_V4L2="v4l2src device=/dev/video0 ! jpegdec ! video/x-raw,width=640,height=480,format=I420,framerate=30/1 ! nvvidconv ! nvv4l2h264enc ! rtph264pay name=pay0 mtu=1300 pt=96"
LAUNCH_STR="videotestsrc ! video/x-raw,width=352,height=288,framerate=15/1 ! nvvidconv ! nvv4l2h264enc ! rtph264pay name=pay0 mtu=1300 pt=96" # default value
# --------------------------------------------------------

function help_usage() {
    echo "$(basename $BASH_SOURCE) [-h] [-p $SERVICE_PORT] [-m $MOUNT_POINT] [-l \"$LAUNCH_STR\"]"
}

# --------------------------------------------------------
# echo BASH_SOURCE=$BASH_SOURCE

THIS_FILE=$(echo $(basename $BASH_SOURCE))
# echo "THIS_FILE=$THIS_FILE"

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
# echo "SHELL_DIR=${SHELL_DIR}"
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "[ $THIS_FILE ]: ERROR: GINGER_HOME not set"
    exit -1
fi
echo "[ $THIS_FILE ]: GINGER_HOME=[${GINGER_HOME}]"
cd $GINGER_HOME
# --------------------------------------------------------

while getopts ":hl:m:p:" opt; do
    case ${opt} in
    h)
        help_usage
        exit 0
        ;;
    p)
        SERVICE_PORT=$OPTARG
        ;;
    m)
        MOUNT_POINT=$OPTARG
        ;;
    l)
        LAUNCH_STR=$OPTARG
        ;;
    \?)
        echo "Invalid option: '$OPTARG'" 1>&2
        exit -1
        ;;
    :)
        echo "Invalid option: '$OPTARG' requires an argument" 1>&2
        exit -2
        ;;
    esac
done
shift $((OPTIND - 1))

echo "[ $THIS_FILE ]: SERVICE_PORT=[${SERVICE_PORT}]"
echo "[ $THIS_FILE ]: MOUNT_POINT=[${MOUNT_POINT}]"
echo "[ $THIS_FILE ]: LAUNCH_STR=[${LAUNCH_STR}]"

export GST_DEBUG=*:2 #,realsensesrc:6,rsdemux:6
echo "[ $THIS_FILE ]: GST_DEBUG=[$GST_DEBUG]"

# open and set dir to dump gstreamer dot file
GST_DOT_DIR=~/tmp
mkdir -p $GST_DOT_DIR
export GST_DEBUG_DUMP_DOT_DIR=$GST_DOT_DIR
echo "[ $THIS_FILE ]: GST_DEBUG_DUMP_DOT_DIR=[$GST_DEBUG_DUMP_DOT_DIR]"

unset DISPLAY

echo ""
echo "[ $THIS_FILE ]: launch $MODULE_NAME on local machine..."
source ros_local.sh
source build/devel/setup.bash
roslaunch $MODULE_NAME rvs_test.launch debug:=true service_port:=$SERVICE_PORT mount_point:=$MOUNT_POINT launch_str:="$LAUNCH_STR"
