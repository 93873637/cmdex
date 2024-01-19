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

CMD="$OIGE_PYTHON rlgames_train.py task=PickerTest headless=True $*"

echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
