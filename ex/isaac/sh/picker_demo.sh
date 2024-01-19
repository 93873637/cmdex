#!/bin/bash

OIGE_HOME=/home/tomli/workspace/cloudfarming/src/picker
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh

cd $OIGE_HOME
CMD="$OIGE_PYTHON scripts/rlgames_demo.py num_envs=1 task=PickerTest checkpoint=$OIGE_HOME/runs/Picker/nn/Picker.pth"
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
