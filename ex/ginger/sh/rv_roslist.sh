#!/bin/bash

echo
echo "[RV]: Active Topics..."
echo "----------------------------------------------------"
rostopic list | grep vision
rostopic list | grep head_camera
rostopic list | grep realsense2_cam
rostopic list | grep /cam3/trichromatic
rostopic list | grep /cam2/image_depth
rostopic list | grep /exposure_parameter
rostopic list | grep object_info_req
echo "----------------------------------------------------"

echo
echo "[RV]: Active Subscribers..."
echo "----------------------------------------------------"
echo "----------------------------------------------------"

echo
echo "[RV]: Active Services..."
echo "----------------------------------------------------"
rosservice list | grep vision
rosservice list | grep 3d_camera_parameters
rosservice list | grep head_camera
rosservice list | grep iris_camera
echo "----------------------------------------------------"

echo
echo "[RV]: Active Service Client..."
echo "----------------------------------------------------"
rosservice list | grep GrpcCommonStream
echo "----------------------------------------------------"
