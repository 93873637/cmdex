#!/bin/bash

#
# IP check sequences:
# 10.x.x.x
# 192.x.x.x
# 127.x.x.x
#
# NOTE:
# if using 127.0.0.1, ros features can only run on local machine,
# remote machine can't access.
#

echo
SH_FILE=$(basename $BASH_SOURCE)
echo "** SH_FILE = $SH_FILE"

echo
LOCAL_IP=`ifconfig | grep inet | grep 'inet 10.' | sed -n '1p' | awk '{print $2}'`
if [ -z $LOCAL_IP ]; then
    LOCAL_IP=`ifconfig | grep inet | grep 'inet 192.' | sed -n '1p' | awk '{print $2}'`
    if [ -z $LOCAL_IP ]; then
        echo "WARNING: no 192.x.x.x ip found, using 127.0.0.1 on local host only..."
        LOCAL_IP=127.0.0.1
    fi
fi
echo "** LOCAL_IP=$LOCAL_IP"

echo
echo "** set ros env with local ip $LOCAL_IP..."
export ROS_MASTER_URI=http://$LOCAL_IP:11311
export ROS_IP=$LOCAL_IP

echo
echo "** To change ros env temporaily, please run:"
echo "source $SH_FILE"

echo
echo "** ROS_MASTER_URI=$ROS_MASTER_URI"
echo "** ROS_IP=$ROS_IP"

echo
