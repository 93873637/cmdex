#!/bin/bash

source ${CMDEX_HOME}/sh/__ccu_curenv.sh
source ${CMDEX_HOME}/sh/__ginger_utils.sh

TAR_NAME=ccu_log_latest
TAR_SRC=$(readlink -f /home/ginger/latest)
echo "** tar source dir: $TAR_SRC"

SRC_COPY=~/tmp/$TAR_NAME

#
# NOTE:
# To avoid error:
# tar: /home/ginger/ginger_logs/0408/16.12.18/cm_ginger.log.1: file changed as we read it
# We need copy latest log out first, then tar it
#
echo "** copy source dir to $SRC_COPY in case tar failed..."
rm -rf $SRC_COPY
mkdir -p $SRC_COPY
cp -rf $TAR_SRC $SRC_COPY

echo "** tar source copy $SRC_COPY..."
tar_log_ts $TAR_NAME $SRC_COPY ~/tmp

echo "** remove source copy $SRC_COPY..."
rm -rf $SRC_COPY

echo
