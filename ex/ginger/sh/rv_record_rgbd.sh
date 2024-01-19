#!/bin/bash

echo
echo "** open robot vision rgbd stream..."
rosservice call /iris_camera/resume

# echo
# DATE=`date +%y.%m%d.%H%M%S`
# BAG_FILE=~/tmp/rv_rgbd_$DATE.bag
# echo "** BAG_FILE=$BAG_FILE"
mkdir -p ~/tmp
cd ~/tmp

# use -o to attach time stamp while -O can't
echo
echo "** start recording..."
rosbag record -o rv_rgbd.bag /realsense2_cam/rgb_depth_stream
