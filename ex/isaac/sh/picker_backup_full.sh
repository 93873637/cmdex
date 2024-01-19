#!/bin/bash

CLOUDFARMING_HOME=/home/tomli/workspace/cloudfarming

TIME_STAMP=`date "+%y.%m%d.%H%M%S"`
SAVE_DIR=$CLOUDFARMING_HOME/res/bak
SAVE_FILE="picker_full_$TIME_STAMP"
if [ $# -ne 0 ]; then
    SAVE_FILE="${SAVE_FILE}_$1"
fi
SAVE_FILE="${SAVE_FILE}.tar.gz"
SAVE_FILE_PATH=$SAVE_DIR/$SAVE_FILE
echo "** get save file: $SAVE_FILE_PATH"

cd $CLOUDFARMING_HOME/src
CMD="tar zcvf $SAVE_FILE_PATH picker"
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
if [ $? -ne 0 ]; then
    echo "** backup failed."
    exit -1
fi

echo
echo "** backup file saved to:"
ls -lh $SAVE_FILE_PATH
echo
