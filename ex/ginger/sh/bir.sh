#!/bin/bash

echo
echo "[BIR]: E..."

# cd this shell dir
SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
echo "SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

# check params
if [ $# -eq 0 ]; then
    echo "Usage: "
    echo "$0 module_name"
    exit -1
fi
MODULE_NAME=$1
echo "[BIR]: get module name: ${MODULE_NAME}"

# stop ginger service first
echo
echo "[BIR]: stop ginger service..."
systemctl stop ginger.service

# build module
echo
echo "[BIR]: build ${MODULE_NAME} module..."
./bio.sh ${MODULE_NAME}
if [ $? -ne 0 ]; then
    echo "[BIR]: build and install ${MODULE_NAME} failed."
    exit -1
fi

# start ginger service
echo
echo "[BIR]: start ginger service..."
systemctl start ginger.service

# NOTE: in case there are some old process and log files, you should sleep some time to wait for them to exit
echo "[BIR]: sleep 10s to view log..."
sleep 10

# view module log
./viewlog.sh ${MODULE_NAME}
