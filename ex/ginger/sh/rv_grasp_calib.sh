#!/bin/bash

set -x

echo "** close face tracking..."
rosservice call /ginger/head_camera/enable_face_tracking "data: false"
echo

echo "** close face detect..."
rosservice call /ginger/head_camera/enable_face_detection "data: false"
echo

echo "** enable pipeline running..."
rosservice call /robot_vision/ctrl "data: 'pipeline:resume'"
echo

echo "** encrease framerate to 30fps..."
rosservice call /robot_vision/ctrl "data: 'camera:frame_rate:30'"
echo

echo "** open color imgae topic publish..."
rosrun dynamic_reconfigure dynparam set /ginger/robot_vision_node "{'publish_color_image': True}"
echo
