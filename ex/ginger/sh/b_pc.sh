#!/bin/bash

# whitelist packages needed for real machine
WHITELIST_PACKAGES=""
# WHITELIST_PACKAGES="$WHITELIST_PACKAGES;robot_engine;"

# blacklist packages excluding from real machine
BLACKLIST_PACKAGES=""
BLACKLIST_PACKAGES="$BLACKLIST_PACKAGES;ginger_manager;action_service"

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
