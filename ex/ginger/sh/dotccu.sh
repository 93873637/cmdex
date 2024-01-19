#!/bin/bash

echo "** Remove ~/tmp/*.dot and *.png files..."
rm ~/tmp/*.dot
rm ~/tmp/*.png

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

echo "** Fetch ccu ~/tmp/*.dot files..."
scp ginger@$CCU_IP:/data/user/ginger/tmp/*.dot ~/tmp
if [ $? -ne 0 ]; then
    echo "** No dot file got from ccu."
    exit -1
fi

dot_dir ~/tmp
