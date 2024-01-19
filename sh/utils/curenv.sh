#!/bin/bash

#
# Usage:
# source utils/curdir.sh
#

echo

# set and cd current directory
CUR_DIR=$(cd "$(dirname "$0")";pwd)
echo "** CUR_DIR: ${CUR_DIR}"
cd $CUR_DIR

# set current file name
# CUR_FILE=`echo $(basename "$0" $BASH_SOURCE)`
CUR_FILE=`echo $(basename "$0")`
echo "** CUR_FILE: ${CUR_FILE}"

# set current date time
CUR_DATE_TIME=`date +%y.%m%d.%H%M%S`
echo "** CUR_DATE_TIME: ${CUR_DATE_TIME}"

echo
