#!/bin/bash

MODULE_NAME=robot_vision

#
# PREREQUISITES:
# the module's launch has set respawn flag to true, so
# only kill module's node, its launch process will restart the module again
#

NODE_NAME=${MODULE_NAME}_node

# go to the shell file's dir
SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR=${SHELL_DIR}"

echo
echo "-- stop $NODE_NAME process..."
MODULE_PID=`ps -efw | grep $NODE_NAME | grep -v grep | awk '{print $2}'`
if [ "$MODULE_PID" = "" ]
then
    echo "-- $NODE_NAME pid not found."
    exit -1
else
    echo "-- find $NODE_NAME pid $MODULE_PID, kill..."
    sudo kill -9 ${MODULE_PID}
fi

echo
MODULE_LAUNCH_PID=`ps -efw | grep ${MODULE_NAME}.launch | grep -v grep | awk '{print $2}'`
if [ "$MODULE_LAUNCH_PID" = "" ]
then
    echo "-- ${MODULE_NAME} launch pid not found, start manually..."
    $SHELL_DIR/rv_start.sh
else
    echo "-- $NODE_NAME's launch process exists, wait respawn automatically..."
fi

MAX_WAIT_COUNT=20
WAIT_COUNT=1
WAIT_TIME=10
echo
while /bin/true; do
    echo "[WAIT #${WAIT_COUNT}/${MAX_WAIT_COUNT}]: sleep ${WAIT_TIME}s to check again..."
    sleep ${WAIT_TIME}s
    
    MODULE_PID=`ps -efw | grep $NODE_NAME | grep -v grep | awk '{print $2}'`
    if [ "$MODULE_PID" != "" ]; then
        echo "view $NODE_NAME($MODULE_PID) process info..."
        ps -ef | grep $NODE_NAME | grep -v grep
        break
    fi
    
    if [ ${WAIT_COUNT} -eq ${MAX_WAIT_COUNT} ]; then
        echo "WARNING: wait $NODE_NAME up to max ${MAX_WAIT_COUNT}, exit."
        exit -2
    else
        WAIT_COUNT=$((${WAIT_COUNT} + 1))
    fi
done

echo
