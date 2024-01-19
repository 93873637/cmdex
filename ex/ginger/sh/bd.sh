#!/bin/bash

SHELL_DIR=$(dirname $BASH_SOURCE)
echo "** SHELL_DIR = $SHELL_DIR"

source $SHELL_DIR/__ginger_utils.sh
check_ros
if [ $? -ne 0 ]; then
    echo "ERROR: check ros failed."
    echo
    exit -1
fi

check_ginger_env
if [ $? -ne 0 ]; then
    echo "ERROR: check ginger env failed."
    echo
    exit -20
fi
cd $GINGER_HOME

echo ""
if [ $# -eq 0 ]; then
    echo "[BD]: Usage: "
    echo "$0 <module_name>"
    echo
    exit -30
fi
MODULE_NAME=$1
echo "[BD]: get module name: $MODULE_NAME"

BUILD_DIR=build
if [ ! -d "$BUILD_DIR" ]; then
    echo "[BD]: create build dir..."
    mkdir $BUILD_DIR
fi
cd $BUILD_DIR

BEGIN_TIME=$(date +%s.%N)
CMD="catkin_make --source ../src --only-pkg-with-deps $MODULE_NAME -j6"
echo "[BD]: run command on dir: $(pwd)"
echo "-----------------"
echo "$CMD"
echo "-----------------"
echo
$CMD 2>&1 | tee build.log
if [ $? -ne 0 ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed."
    echo
    exit -40
fi

# check if package not found
# Packages "rvv" not found in the workspace
PACKAGE_NOT_FOUND=$(tail -n -3 build.log | grep "not found")
if [ ! -z "$PACKAGE_NOT_FOUND" ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed: $PACKAGE_NOT_FOUND"
    echo
    exit -50
fi

# if build failed, last line should be:
# Invoking "make -j6" failed
FIND_BUILD_FAILED=$(tail -n -3 build.log | grep failed)
# echo $FIND_BUILD_FAILED
if [ ! -z "$FIND_BUILD_FAILED" ]; then
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed: $FIND_BUILD_FAILED"
    echo
    exit -60
fi

# check if time skew, in case invalid building on deprecated files
FIND_CLOCK_SKEW=$(grep "Clock skew detected" build.log | tail -1)
# echo $FIND_CLOCK_SKEW
if [ ! -z "$FIND_CLOCK_SKEW" ]; then
    echo "[BD]: WARNING: Clock skew found - $FIND_CLOCK_SKEW"
    echo "[BD]: WARNING: The system time is [ $(date) ], is it correct?"
    echo "[BD]: ERROR: catkin_make '$MODULE_NAME' failed for clock skew."
    echo
    exit -70
fi

END_TIME=$(date +%s.%N)
TIME_USED=$(calculate_time_diff $BEGIN_TIME $END_TIME)
echo
echo "[BD]: catkin_make '$MODULE_NAME' success, time used: ${TIME_USED}s"

echo
