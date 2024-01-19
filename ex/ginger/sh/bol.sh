#!/bin/bash

echo ""
if [ $# -eq 0 ];
then
    echo "Usage: "
    echo "$0 module_name"
    exit
fi
MODULE_NAME=$1
echo "[BOL]: get module name: ${MODULE_NAME}"

echo ""
echo "build ${MODULE_NAME} module..."
./bo.sh ${MODULE_NAME}
if [ $? -ne 0 ]; then
    echo "build ${MODULE_NAME} failed."
    exit -1
fi

echo ""
echo "launch ${MODULE_NAME} module..."
./l_${MODULE_NAME}.sh
