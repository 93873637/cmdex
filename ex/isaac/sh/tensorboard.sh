#!/bin/bash

LOG_DIR=runs/
# if [ $# -eq 0 ]; then
    # echo
    # echo "Usage: tb <log-dir>"
    # echo
    # exit 0
# fi

if [ $# -ne 0 ]; then
    LOG_DIR=$1
fi

CMD="tensorboard --logdir $LOG_DIR"
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
