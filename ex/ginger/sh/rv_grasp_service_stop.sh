#!/bin/bash

set -x

echo "** stop publish detect image..."
rosrun dynamic_reconfigure dynparam set /ginger/robot_vision_node "{'publish_osd_image': False}"
echo

echo "** close local cv..."
rosservice call /robot_vision/enable_object_detect "data: false"
echo

echo "** decrease framerate to 15fps..."
rosservice call /robot_vision/ctrl "data: 'camera:frame_rate:15'"
echo

echo "** restore face detect..."
rosservice call /ginger/head_camera/enable_face_detection "data: true"
echo

echo "** restore face tracking..."
rosservice call /ginger/head_camera/enable_face_tracking "data: true"
echo
