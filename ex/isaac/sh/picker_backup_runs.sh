#!/bin/bash


CLOUDFARMING_HOME=/home/tomli/workspace/cloudfarming

PICKER_HOME=$CLOUDFARMING_HOME/src/picker
BACKUP_DIR=$CLOUDFARMING_HOME/src/picker/runs/Picker

TIME_STAMP=`date "+%y.%m%d.%H%M"`
SAVE_DIR=$CLOUDFARMING_HOME/res/runs/Picker_$TIME_STAMP
if [ $# -ne 0 ]; then
    SAVE_DIR="${SAVE_DIR}_$1"
fi

CMD="cp -rf $BACKUP_DIR $SAVE_DIR"
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
echo "** backup $BACKUP_DIR to "
echo "$SAVE_DIR: "
ls -lh $SAVE_DIR
echo
