#!/bin/bash

MODULE_NAME=robot_vision

PROC_NAME=${MODULE_NAME}_node

PID_NUM=`ps -efw | grep $PROC_NAME | grep -v grep | awk '{print $2}' | wc -l`
echo "** PID_NUM='$PID_NUM'"
if [ $PID_NUM -eq 0 ];then
    echo "ERROR: no pid of $PROC_NAME found."
    exit -1
fi
if [ $PID_NUM -gt 1 ];then
    echo "ERROR: find $PID_NUM pid of $PROC_NAME, please check."
    exit -2
fi

MODULE_PID=`ps -efw | grep ${MODULE_NAME}_node | grep -v grep | awk '{print $2}'`
top -p $MODULE_PID

#################################
# -H to show all thread?
# top -H -p $MODULE_PID
