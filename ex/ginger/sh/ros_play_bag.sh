#!/bin/bash

#
# loop playing a rosbag file on local machine, start roscore if not running
#

# check if ros bag file given
if [ $# -eq 0 ]; then
    echo "[CXX]: Usage: "
    echo "$0 ros_bag_file"
    exit -1
fi
BAG_FILE=$1
echo "BAG_FILE=$BAG_FILE"

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=${GINGER_HOME}"
# --------------------------------------------------------

echo ""
echo "set ros on local machine..."
source $GINGER_HOME/src/cr-tools/cmdex_tools/scripts/sh/ros_local.sh

# start roscore if not running
# --------------------------------------------------------
ROS_CORE=$(ps -ef | grep roscore | grep -v grep)
echo
if [ "$ROS_CORE" != "" ]; then
    echo "[CXX]: roscore already statrt"
else
    echo "[CXX]: start roscore..."
    roscore &
    MAX_WAIT_COUNT=20
    WAIT_COUNT=1
    while /bin/true; do
        if [ $(rosnode list 2>/dev/null | grep "/rosout") ]; then
            echo
            echo "[CXX]: roscore #${WAIT_COUNT}: success"
            echo
            break
        else
            echo
            echo "[CXX]: roscore #${WAIT_COUNT}: wait..."
            echo
        fi
        sleep 1 # wait for 1 second

        if [ ${WAIT_COUNT} -eq ${MAX_WAIT_COUNT} ]; then
            echo "ERROR: wait roscore up to max ${MAX_WAIT_COUNT}, start failed"
            exit -2
        else
            WAIT_COUNT=$((${WAIT_COUNT} + 1))
        fi
    done
fi
# --------------------------------------------------------

trap 'onCtrlC' INT
function onCtrlC() {
    echo '[CXX]: Ctrl+C exit'
    echo
    exit -3
}

# loop playing ros bag
echo
PLAY_COUNT=0
while true; do
    PLAY_COUNT=$((${PLAY_COUNT} + 1))
    echo "[CXX]: play ros bag $BAG_FILE #$PLAY_COUNT..."
    rosbag play $BAG_FILE
    echo
done
