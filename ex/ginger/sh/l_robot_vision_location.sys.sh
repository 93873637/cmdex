#!/bin/bash

#
# launch system integrated robot vision which locate on /vendor/ginger_robot
#

# disable display which maybe added by MobaXterm
echo "** disable gstreamer disaply..."
unset DISPLAY
rm $HOME/.cache/gstreamer-1.0/registry.*

echo "** launch robot vision of /vendor/ginger_robot..."
source /vendor/ginger_robot/install/setup.bash
roslaunch robot_vision_location robot_vision_location.launch debug:=true
