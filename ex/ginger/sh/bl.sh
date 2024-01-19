#!/bin/bash

# cd this shell dir
SHELL_DIR=$(cd "$(dirname "$0")";pwd)
echo "SHELL_DIR=${SHELL_DIR}"
cd $SHELL_DIR

echo ""
if [ $# -eq 0 ];
then
    echo "Usage: "
    echo "$0 module_name"
    exit -1
fi
MODULE_NAME=$1
echo "[BL]: get module name: ${MODULE_NAME}"

echo ""
echo "[BL]: build ${MODULE_NAME} module..."
./bdl.sh ${MODULE_NAME}
if [ $? -ne 0 ]; then
    echo "[BL]: build ${MODULE_NAME} failed."
    exit -1
fi
