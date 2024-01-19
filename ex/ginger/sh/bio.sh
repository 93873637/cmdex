#!/bin/bash

# ----------------------------------------------------
# Variable Settings

INSTALL_DIR=/vendor/ginger_robot/install
# INSTALL_DIR=/vendor/install  # for patrol3
echo "INSTALL_DIR=${INSTALL_DIR}"

# ----------------------------------------------------

echo ""
if [ $# -eq 0 ]; then
    echo "Usage: "
    echo "$0 module_name"
    exit -1
fi
MODULE_NAME=$1
echo "[BIO]: get module name: ${MODULE_NAME}"

# --------------------------------------------------------
if [ -z $GINGER_HOME ]; then
    echo "ERROR: GINGER_HOME not set"
    exit -2
fi
echo "** GINGER_HOME = $GINGER_HOME"
# --------------------------------------------------------

cd $GINGER_HOME

# set build start time
BUILD_DIR=$GINGER_HOME/build
mkdir -p $BUILD_DIR && cd $BUILD_DIR

# set build start time
build_start_time=$(date +"%Y-%m-%d %H:%M:%S")
build_start_time_timestamp=$(date -d "$build_start_time" +%s)

# catkin make and install
echo ""
echo "[BIO]: build and install module ${MODULE_NAME} only..."
WHITELIST_PACKAGES="${MODULE_NAME}"
CMD="catkin_make install --source ../src -DCATKIN_WHITELIST_PACKAGES=${WHITELIST_PACKAGES} -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}"
echo "[BD]: run command on dir: $(pwd)"
echo "-----------------"
echo "$CMD"
echo "-----------------"
echo
$CMD 2>&1 | tee build.log
if [ $? -ne 0 ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed."
    exit -1
fi

# check if package not found
# Packages "rvv" not found in the workspace
PACKAGE_NOT_FOUND=$(tail -n -3 build.log | grep "not found")
if [ ! -z "$PACKAGE_NOT_FOUND" ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed: $PACKAGE_NOT_FOUND"
    exit -2
fi

# if build failed, last line should be:
# Invoking "make -j6" failed
FIND_BUILD_FAILED=$(tail -n -3 build.log | grep failed)
# echo $FIND_BUILD_FAILED
if [ ! -z "$FIND_BUILD_FAILED" ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed: $FIND_BUILD_FAILED"
    exit -3
fi

# check if time skew, in case invalid building on deprecated files
FIND_CLOCK_SKEW=$(grep "Clock skew detected" build.log | tail -1)
# echo $FIND_CLOCK_SKEW
if [ ! -z "$FIND_CLOCK_SKEW" ]; then
    echo "[BD]: WARNING: Clock skew found - $FIND_CLOCK_SKEW"
    echo "[BD]: WARNING: The system time is [ $(date) ], is it correct?"
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed for clock skew."
    exit -4
fi

# set build end time and calculate time-consuming
build_end_time=$(date +"%Y-%m-%d %H:%M:%S")
build_end_time_timestamp=$(date -d "$build_end_time" +%s)
build_time_consuming=$(expr $build_end_time_timestamp - $build_start_time_timestamp)
ss=$(($build_time_consuming % 60))
mm=$(($build_time_consuming / 60))
if [ $ss -lt 10 ]; then
    ss="0${ss}"
else
    ss="${ss}"
fi

# output success
echo ""
echo -e "\033[0;32m[BIO]: build and install module ${MODULE_NAME} success, time elapsed ${mm}:${ss}\033[0m"
echo ""
