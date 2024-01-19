#!/bin/bash

# --------------------------------------------------------
# echo BASH_SOURCE=$BASH_SOURCE

THIS_FILE=$(echo $(basename $BASH_SOURCE))
echo "THIS_FILE=$THIS_FILE"

SHELL_DIR=$(
    cd "$(dirname "$0")"
    pwd
)
echo "SHELL_DIR=${SHELL_DIR}"
# --------------------------------------------------------

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -1
fi
echo "GINGER_HOME=${GINGER_HOME}"
cd $GINGER_HOME
# --------------------------------------------------------

source $SHELL_DIR/ros_local.sh

##
# gstreamer log def
#
# https://gstreamer.freedesktop.org/documentation/tutorials/basic/debugging-tools.html?gi-language=c
#
# The first category is the Debug Level, which is a number specifying the amount of desired output:
#
# | # | Name    | Description                                                    |
# |---|---------|----------------------------------------------------------------|
# | 0 | none    | No debug information is output.                                |
# | 1 | ERROR   | Logs all fatal errors. These are errors that do not allow the  |
# |   |         | core or elements to perform the requested action. The          |
# |   |         | application can still recover if programmed to handle the      |
# |   |         | conditions that triggered the error.                           |
# | 2 | WARNING | Logs all warnings. Typically these are non-fatal, but          |
# |   |         | user-visible problems are expected to happen.                  |
# | 3 | FIXME   | Logs all "fixme" messages. Those typically that a codepath that|
# |   |         | is known to be incomplete has been triggered. It may work in   |
# |   |         | most cases, but may cause problems in specific instances.      |
# | 4 | INFO    | Logs all informational messages. These are typically used for  |
# |   |         | events in the system that only happen once, or are important   |
# |   |         | and rare enough to be logged at this level.                    |
# | 5 | DEBUG   | Logs all debug messages. These are general debug messages for  |
# |   |         | events that happen only a limited number of times during an    |
# |   |         | object's lifetime; these include setup, teardown, change of    |
# |   |         | parameters, etc.                                               |
# | 6 | LOG     | Logs all log messages. These are messages for events that      |
# |   |         | happen repeatedly during an object's lifetime; these include   |
# |   |         | streaming and steady-state conditions. This is used for log    |
# |   |         | messages that happen on every buffer in an element for example.|
# | 7 | TRACE   | Logs all trace messages. Those are message that happen very    |
# |   |         | very often. This is for example is each time the reference     |
# |   |         | count of a GstMiniObject, such as a GstBuffer or GstEvent, is  |
# |   |         | modified.                                                      |
# | 9 | MEMDUMP | Logs all memory dump messages. This is the heaviest logging and|
# |   |         | may include dumping the content of blocks of memory.           |
# +------------------------------------------------------------------------------+
##
export GST_DEBUG=*:1,realsensesrc:4,rsdemux:2
echo "[ $THIS_FILE ]: set GST_DEBUG=$GST_DEBUG"

# open and set dir to dump gstreamer dot file
GST_DOT_DIR=~/tmp
mkdir -p $GST_DOT_DIR
export GST_DEBUG_DUMP_DOT_DIR=$GST_DOT_DIR
echo "[ $THIS_FILE ]: set GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

# set realsensesrc plugin path
ARCH=$(arch)
if [ "$ARCH" == "x86_64" ]; then
    echo "[ $THIS_FILE ]: ARCH = x86_64"
elif [ "$ARCH" == "aarch64" ]; then
    echo "[ $THIS_FILE ]: ARCH = aarch64"
else
    echo "ERROR: Unsupport ARCH '$ARCH'"
    exit -1
fi
export GST_PLUGIN_PATH=/vendor/lib/gstreamer-1.0/:/usr/lib/${ARCH}-linux-gnu/gstreamer-1.0:$GST_PLUGIN_PATH
echo "[ $THIS_FILE ]: set GST_PLUGIN_PATH=$GST_PLUGIN_PATH"

UN_BUF="stdbuf -oL -eL "
ROS_USER_LAUNCH="roslaunch"

: '
# run roscore on daemon first
# ------------------------------------------------------------------------
echo ""
echo "[ $THIS_FILE ]: start roscore for access by external..."
roscore &
MAX_WAIT_COUNT=20
count=1
while /bin/true; do
    if [ $(rosnode list 2>/dev/null | grep "/rosout") ]; then
        echo
        echo "[ $THIS_FILE ]: roscore #${count}: success"
        echo
        break
    else
        echo
        echo "[ $THIS_FILE ]: roscore #${count}: wait..."
        echo
    fi
    sleep 1 # wait for 1 second

    if [ ${count} -eq ${MAX_WAIT_COUNT} ]; then
        echo "[ $THIS_FILE ]: wait count up to max: ${MAX_WAIT_COUNT}"
        break
    else
        count=$((${count} + 1))
    fi
done
set -e # exit immediately if a command return a non-zero status.
ROS_USER_LAUNCH="roslaunch --wait"
# ------------------------------------------------------------------------
'

# launch robot vision
echo ""
echo "[ $THIS_FILE ]: launch robot vision on local machine..."

source /opt/ros/$ROS_DISTRO/setup.bash
source ./build/devel/setup.bash
# ${ROS_USER_LAUNCH} robot_vision robot_vision.launch debug:=true

# --------------------------------------------------------
# set log file
# --------------------------------------------------------
LOG_DIR=~/tmp/log
echo "[ $THIS_FILE ]: set LOG_DIR=${LOG_DIR}"

if [ ! -d "${LOG_DIR}" ]; then
    echo "[ $THIS_FILE ]: log dir '${LOG_DIR}' not exists, create..."
    mkdir -p ${LOG_DIR}
fi

DATE_TIME=$(date +%y.%m%d.%H%M%S)
LOG_FILE=${LOG_DIR}/robot_vision_${DATE_TIME}.log
echo "[ $THIS_FILE ]: set LOG_FILE=${LOG_FILE}"
# --------------------------------------------------------

# disable display which maybe added by MobaXterm
echo "** disable gstreamer disaply..."
unset DISPLAY
GST_REG_FILES=($HOME/.cache/gstreamer-1.0/registry.*)
# echo $GST_REG_FILES
if ls $GST_REG_FILES 1>/dev/null 2>&1; then
    echo "** remove gstreamer registry files..."
    rm $HOME/.cache/gstreamer-1.0/registry.*
fi
echo
echo

${UN_BUF} ${ROS_USER_LAUNCH} robot_vision robot_vision.launch debug:=false 2>&1 | tee ${LOG_FILE}

# run robot_vision on daemon and view log
# ${UN_BUF} ${ROS_USER_LAUNCH} robot_vision robot_vision.launch debug:=true >${LOG_FILE} 2>&1 &
# echo "[ $THIS_FILE ]: view robot vision log '$LOG_FILE'..."
# echo
# tail -f $LOG_FILE
