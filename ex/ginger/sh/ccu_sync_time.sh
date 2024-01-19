#!/bin/bash

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "** GINGER_HOME = $GINGER_HOME"
# --------------------------------------------------------

# 2022-06-02 20:27:20.2600000000 ./src/robot_vision/robot_vision/src/robot_vision/transform_provider.cpp
LATEST_FILE=$(find $GINGER_HOME/src -type f -printf '%TY-%Tm-%Td %TT %p\n' | sort -r | head -n 1)
echo "** LATEST_FILE = $LATEST_FILE"

# ** LATEST_FILE_TIME = 2022-06-02 20:27:20
LATEST_FILE_TIME=${LATEST_FILE:0:19}
echo "** LATEST_FILE_TIME = $LATEST_FILE_TIME"

# ** CUR_SYS_TIME = 2022-06-01 12:29:59
CUR_SYS_TIME=$(date +"%Y-%m-%d %H:%M:%S")
echo "** CUR_SYS_TIME = $CUR_SYS_TIME"

if [ "$LATEST_FILE_TIME" == "$CUR_SYS_TIME" ]; then
    echo "** lastest file time same as system time, not sync"
    exit 0
fi

rm -rf /tmp/ccu_sync_time.txt
echo $CUR_SYS_TIME >>/tmp/ccu_sync_time.txt
echo $LATEST_FILE_TIME >>/tmp/ccu_sync_time.txt
LATEST_TIME=$(cat /tmp/ccu_sync_time.txt | sort -rn | head -n 1)
echo "** LATEST_TIME = $LATEST_TIME"

if [ "$CUR_SYS_TIME" == "$LATEST_TIME" ]; then
    echo "** lastest file time '$LATEST_FILE_TIME' is NOT in the future of system time '$CUR_SYS_TIME', no sync."
    exit 0
fi

echo "WARNING: lastest file time '$LATEST_FILE_TIME' is in the future of system time '$CUR_SYS_TIME', sync time..."
echo "ginger" | sudo -S date -s "$LATEST_TIME"

echo
echo "** ccu system time update:"
date
echo

echo "** remove old build..."
cx_clear.sh
