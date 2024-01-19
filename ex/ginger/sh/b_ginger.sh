#!/bin/bash

# whitelist packages needed for real machine
WHITELIST_PACKAGES=""
# WHITELIST_PACKAGES="$WHITELIST_PACKAGES;robot_engine;"

# blacklist packages excluding from real machine
BLACKLIST_PACKAGES="cloudrobot_simulation"
BLACKLIST_PACKAGES="$BLACKLIST_PACKAGES;robot_grasping_test"

echo ""
echo "** stop ginger service..."
systemctl stop ginger.service

BUILD_DIR=../build
mkdir -p $BUILD_DIR
cd $BUILD_DIR

echo ""
echo "** catkin_make..."
catkin_make --source ../src -DCATKIN_WHITELIST_PACKAGES=$WHITELIST_PACKAGES -DCATKIN_BLACKLIST_PACKAGES=$BLACKLIST_PACKAGES -j6
if [ $? -ne 0 ]; then
    echo "catkin_make failed."
    exit -1
fi
cd ..

# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# -- ~~  traversing 45 packages in topological order:
# -- ~~  - ginger_moveit_config
# -- ~~  - realsense2_description
# -- ~~  - rosconsole
# -- ~~  - controller_focus_manager_msgs
# -- ~~  - ginger_dumpsys_msgs
# -- ~~  - actuator_param_interface
# -- ~~  - actuator_status_interface
# -- ~~  - cloud_robot_utils
# -- ~~  - hardware_interface
# -- ~~  - joint_param_interface
# -- ~~  - joint_param_controller
# -- ~~  - joint_homing_param_controller
# -- ~~  - ros_jetson_stats
# -- ~~  - cr_controller_configuration
# -- ~~  - robot_analyzer
# -- ~~  - sensor_interface
# -- ~~  - battery_controller
# -- ~~  - drop_collission_controller
# -- ~~  - ecu_buttons_controller
# -- ~~  - controller_focus_manager
# -- ~~  - blc_controller_test
# -- ~~  - effort_controller_test
# -- ~~  - ginger_common_msgs
# -- ~~  - head_camera_viewer
# -- ~~  - imu_sensor_controller
# -- ~~  - cloud_robot_msgs
# -- ~~  - omni_wheels_controller
# -- ~~  - realsense2_camera
# -- ~~  - pointcloud_to_laserscan
# -- ~~  - transmission_interface
# -- ~~  - ultrasonic_controller_msg
# -- ~~  - ultrasonic_controller
# -- ~~  - generic_robot_hal
# -- ~~  - omni_wheels_balancing_controller
# -- ~~  - omni_wheels_odom_controller
# -- ~~  - robot_auto_homing
# -- ~~  - robot_engine
# -- ~~  - ginger_description
# -- ~~  - animation_tools
# -- ~~  - head_camera
# -- ~~  - robot_animation
# -- ~~  - animation_engine_client
# -- ~~  - ginger_manager
# -- ~~  - joint_trajectory_controller
# -- ~~  - unlimit_controller
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
# -- ~~  - animation_tools
# -- ~~  - head_camera
# -- ~~  - robot_animation
# -- ~~  - animation_engine_client
# -- ~~  - ginger_manager
# -- ~~  - joint_trajectory_controller
# -- ~~  - unlimit_controller
# -- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
