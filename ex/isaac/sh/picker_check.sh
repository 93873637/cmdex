#!/bin/bash

PICKER_HOME=/home/tomli/workspace/cloudfarming/src/picker
ISAAC_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh

if [ $# -eq 0 ]; then
    echo
    echo "** Usage: "
    echo "pkc <checkpoint=path-to-pth-file> [param1=value1]..."
    echo
    exit 0
fi

cd $PICKER_HOME
CMD="$ISAAC_PYTHON rlgames_train.py num_envs=1 task=PickerTest test=True $*"
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
