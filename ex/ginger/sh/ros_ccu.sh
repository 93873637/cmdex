#!/bin/bash

HOST_IP=192.168.1.200

echo "** set roscore on local machine..."
export ROS_MASTER_URI=http://${HOST_IP}:11311
export ROS_IP=${HOST_IP}

echo "** ROS_MASTER_URI=$ROS_MASTER_URI"
echo "** ROS_IP=$ROS_IP"
