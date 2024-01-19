#!/bin/bash

PICKER_HOME=/home/tomli/workspace/cloudfarming/src/picker

BACKUP_DIR="cfg/ deploy/ docs/ robots/ scripts/ tasks/ utils/ runs/ *.md"

TIME_STAMP=`date "+%y.%m%d.%H%M%S"`
SAVE_DIR=$PICKER_HOME/res/bak
SAVE_FILE="picker_$TIME_STAMP"
if [ $# -ne 0 ]; then
    SAVE_FILE="${SAVE_FILE}_$1"
fi
SAVE_FILE="${SAVE_FILE}.tar.gz"
SAVE_FILE_PATH=$SAVE_DIR/$SAVE_FILE
echo "** get save file: $SAVE_FILE_PATH"

cd $PICKER_HOME
CMD="tar zcvf $SAVE_FILE_PATH $BACKUP_DIR"
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
