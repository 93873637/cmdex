#!/bin/bash

#
# build and install module with stopping ginger service first
#

# check param
if [ $# -eq 0 ];
then
    echo "Usage: "
    echo "$0 module_name"
    exit -1
fi
MODULE_NAME=$1
echo "[BIR]: get module name: ${MODULE_NAME}"

# stop ginger service before build
echo ""
echo "[BI]: stop ginger service..."
systemctl stop ginger.service

# build module
SHELL_DIR=$(cd "$(dirname "$0")";pwd)
echo "SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR
./bio.sh ${MODULE_NAME}
