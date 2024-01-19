#!/bin/bash

# cd this shell dir
SHELL_DIR=$(dirname $BASH_SOURCE)
echo "SHELL_DIR=$SHELL_DIR"
cd $SHELL_DIR

echo ""
if [ $# -eq 0 ];
then
    echo "Usage: "
    echo "$0 module_name"
    exit -1
fi
MODULE_NAME=$1
echo "[BDL]: get module name: ${MODULE_NAME}"

echo ""
echo "[BDL]: build module ${MODULE_NAME}..."
./bd.sh ${MODULE_NAME}
if [ $? -ne 0 ]; then
    echo "[BDL]: build module ${MODULE_NAME} failed."
    exit -1
fi

echo ""
echo "[BDL]: launch module ${MODULE_NAME}..."
pwd
./l_${MODULE_NAME}.sh
