#!/bin/bash

MODULE_NAME=robot_vision

clear

echo
echo "[`date "+%Y-%m-%d %H:%M:%S"`] $MODULE_NAME"
echo

echo "[Ginger Service]:"
systemctl status ginger | grep Active
echo

MODULE_LAUNCH_PID=`ps -efw | grep ${MODULE_NAME}.launch | grep -v grep | awk '{print $2}'`
# echo "MODULE_LAUNCH_PID='$MODULE_LAUNCH_PID'"
if [ "$MODULE_LAUNCH_PID" = "" ];then
    echo "[LAUNCH PID]: not found."
else
    echo "[LAUNCH PID]: $MODULE_LAUNCH_PID"
fi

MODULE_PID_NUM=`ps -efw | grep ${MODULE_NAME}_node | grep -v grep | awk '{print $2}' | wc -l`
# echo "##@: MODULE_PID_NUM='$MODULE_PID_NUM'"
if [ $MODULE_PID_NUM -eq 0 ];then
    echo "[MODULE PID]: not found."
    exit -1
fi
if [ $MODULE_PID_NUM -eq 1 ];then
    MODULE_PID=`ps -efw | grep ${MODULE_NAME}_node | grep -v grep | awk '{print $2}'`
else
    MODULE_PID=`ps -efw | grep ${MODULE_NAME}_node | grep -v grep | awk '{print $2}' | sed -n '2p'`
fi
echo "[MODULE PID]: ${MODULE_PID}"

THREAD_NUM=`cat /proc/${MODULE_PID}/status | grep Threads | awk '{print $2}'`
echo "[THREAD NUM]: $THREAD_NUM"

MODULE_MEM=`cat /proc/${MODULE_PID}/status | grep -e VmRSS | awk '{print $2}'`
echo "[MODULE MEM]: $MODULE_MEM KB"

MODULE_CPU=`ps aux |grep ${MODULE_PID}| grep -v grep | awk '{print($3);}'`
echo "[MODULE CPU]: %${MODULE_CPU}"

# module start and elapse time
echo
ps -o lstart,etime -p ${MODULE_PID}
echo

ps aux|head -1;ps aux | grep ${MODULE_PID} | grep -v grep
echo

##################################################################

# PSINFO=`top -p$MODULE_PID`
# echo $PSINFO
# top -H -p $MODULE_PID

# ps -o user,%cpu,%mem,command
# ps aux |grep 21995| grep -v grep | awk '{print($1" "$3" "$4" "$11);}'
# kevin 0.1 0.1 /home/kevin/work/ros_gdb_test/build/devel/lib/ros_gdb_test/ros_gdb_test_node
