#!/bin/bash

#
# launch system integrated robot vision which locate on /vendor/ginger_robot
#

# disable display which maybe added by MobaXterm
echo "** disable gstreamer disaply..."
unset DISPLAY
rm $HOME/.cache/gstreamer-1.0/registry.*

export GST_PLUGIN_PATH=/vendor/lib/gstreamer-1.0/:$GST_PLUGIN_PATH
echo "** GST_PLUGIN_PATH=$GST_PLUGIN_PATH"

GST_DOT_DIR=~/tmp
mkdir -p $GST_DOT_DIR
export GST_DEBUG_DUMP_DOT_DIR=$GST_DOT_DIR
echo "** GST_DEBUG_DUMP_DOT_DIR=$GST_DEBUG_DUMP_DOT_DIR"

export GST_DEBUG=*:2 #realsensesrc:2,rsdemux:2,nvinfer:6,nvtracker:6
echo "** GST_DEBUG=$GST_DEBUG"

echo "** launch robot vision of /vendor/ginger_robot..."
source /vendor/ginger_robot/install/setup.bash
roslaunch robot_vision robot_vision.launch debug:=true
