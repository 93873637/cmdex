#!/bin/bash

# currently, limited by system performance,
# to run grasp service, i.e. object detection, need:
# 1. close face/person detect
# 2. rise up frame to 30fps
# 3. open object detection

set -x

echo "** close face tracking..."
rosservice call /ginger/head_camera/enable_face_tracking "data: false"
echo

echo "** close face detect to save cpu/mem..."
rosservice call /ginger/head_camera/enable_face_detection "data: false"
echo

echo "** encrease framerate to 30fps..."
rosservice call /robot_vision/ctrl "data: 'camera:frame_rate:30'"
echo

echo "** open local cv..."
rosservice call /robot_vision/enable_object_detect "data: true"
echo

echo "** publish detect image..."
rosrun dynamic_reconfigure dynparam set /ginger/robot_vision_node "{'publish_osd_image': True}"
echo
