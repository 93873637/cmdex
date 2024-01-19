#!/bin/bash

# go to the shell file's dir
SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

if [ $# -ne 1 ]; then
    echo "Usage: `basename $0` </dev/video*>"
    exit -1
fi

VIDEO_DEVICE=$1
LAUNCH_STR="v4l2src device=$VIDEO_DEVICE ! jpegdec ! video/x-raw,width=640,height=480,format=I420,framerate=30/1 ! nvvidconv ! nvv4l2h264enc ! rtph264pay name=pay0 mtu=1300 pt=96"
echo "** LAUNCH_STR=[$LAUNCH_STR]"
./rvs_test.sh -l "$LAUNCH_STR"
