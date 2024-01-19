#!/bin/bash

if [ -z $GINGER_HOME ]; then
    echo "ERROR: env GINGER_HOME not set"
    exit -1
fi

SRC_DIR=$GINGER_HOME/src/third_party/realsense_gstreamer_plugin/
TAR_DIR=/data/user/ginger/ginger441/src/third_party/

if [ ! -d "$SRC_DIR" ]; then
    echo "ERROR: source dir '$SRC_DIR' not exist"
    exit -2
fi

# -----------------------------------------------
# get CCU_IP

# go to the shell file's dir
SHELL_DIR=$(dirname $BASH_SOURCE)
# echo "SHELL_DIR=${SHELL_DIR}"
source $SHELL_DIR/__ginger_utils.sh

echo "** get ccu ip..."
get_ccu_ip
if [ $? -ne 0 ]; then
    echo "get ccu ip failed"
    exit -1
fi
echo "** CCU_IP=$CCU_IP"
# -----------------------------------------------

echo "** scp -r $SRC_DIR -> $CCU_IP:$TAR_DIR"
scp -r $SRC_DIR ginger@$CCU_IP:$TAR_DIR
