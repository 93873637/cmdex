#!/bin/bash

##
#
# function calculate_time_diff
#
# @input: t1, t2
# @return: t2 - t1, time diff in milli-seconds
#
# Usage:
#
# BEGIN_TIME=$(date +%s.%N)
#
# # do something...
#
# END_TIME=$(date +%s.%N)
# TIME_USED_MS=$(calculate_time_diff $BEGIN_TIME $END_TIME)
# echo "time used: ${TIME_USED_MS}ms"
#
function calculate_time_diff()
{
    t1=$1
    t2=$2
    start_s=$(echo $t1 | cut -d '.' -f 1)
    start_ns=$(echo $t1 | cut -d '.' -f 2)
    end_s=$(echo $t2 | cut -d '.' -f 1)
    end_ns=$(echo $t2 | cut -d '.' -f 2)
    time_ms=$(((10#$end_s - 10#$start_s) * 1000 + (10#$end_ns / 1000000 - 10#$start_ns / 1000000)))
    echo "$time_ms"
}

#
# To train task Picker with default parameters if not given
#
MAX_EPOCHS=20

OIGE_HOME=/home/tomli/workspace/cloudfarming/src/picker
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh
OUT_DIR=runs/Picker

cd $OIGE_HOME

## build command
CMD="$OIGE_PYTHON rlgames_train.py task=PickerTest"
CMD="$CMD headless=True"
# CMD="$CMD num_envs=8"
# CMD="$CMD episode_length=100"
CMD="$CMD max_iterations=$MAX_EPOCHS"
# CMD="$CMD horizon_length=16"
# CMD="$CMD minibatch_size=16"

## run command
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo "$CMD"
echo "~~~~~~~~~~~~~~~~~~~"
echo
BEGIN_TIME=$(date +%s.%N)
$CMD
if [ $? -ne 0 ]; then
    echo "ERROR: Train test failed."
    exit -1
fi

END_TIME=$(date +%s.%N)
TIME_USED_MS=$(calculate_time_diff $BEGIN_TIME $END_TIME)
TIME_USED=$((TIME_USED_MS / 1000))
EPOCH_TIME=$((TIME_USED_MS / MAX_EPOCHS))
echo
echo "** Train test finished, time used: ${TIME_USED}s, epoch_time: ${EPOCH_TIME}ms"
echo
