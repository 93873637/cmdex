#!/bin/bash

#
# To train task Picker with default parameters if not given
#

OIGE_HOME=/home/tomli/workspace/cloudfarming/src/picker
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh
OUT_DIR=runs/Picker

cd $OIGE_HOME

## clear output to rebuild
echo
echo "** clear output dir '$OUT_DIR' to rebuild..."
rm -rf $OUT_DIR

## build command
CMD="$OIGE_PYTHON rlgames_train.py task=PickerTest"

CMD="$CMD headless=True"
CMD="$CMD num_envs=4"
CMD="$CMD episode_length=10"
# CMD="$CMD dt=0.001"
CMD="$CMD max_iterations=1"  # i.e. max_epochs

CMD="$CMD position_goal=0.1"  # meter
CMD="$CMD rotation_goal=0.5"  # rad

# num_actors * horizon_length % minibatch_size == 0
CMD="$CMD horizon_length=16"
CMD="$CMD minibatch_size=16"

## set log file
WITH_LOG_FILE=0
if [ $WITH_LOG_FILE -eq 1 ]; then
    LOG_DIR=~/tmp/log
    if [ ! -d "$LOG_DIR" ]; then
        echo "** log dir '$LOG_DIR' not exists, create..."
        mkdir -p $LOG_DIR
    fi
    DATE_TIME=$(date +%y.%m%d.%H%M%S)
    LOG_FILE=$LOG_DIR/picker_develop_${DATE_TIME}.log
    echo "** set LOG_FILE=$LOG_FILE"
fi

## run command
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo "$CMD"
echo "~~~~~~~~~~~~~~~~~~~"
echo
if [ $WITH_LOG_FILE -eq 1 ]; then
    $CMD 2>&1 | tee ${LOG_FILE}
else
    $CMD
fi
