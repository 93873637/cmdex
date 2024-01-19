#!/bin/bash

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

ssh -o "strictHostKeyChecking no" ginger@$CCU_IP
