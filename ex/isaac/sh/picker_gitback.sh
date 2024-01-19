#!/bin/bash

#
# To train task Picker with default parameters if not given
#

OIGE_HOME=/home/tomli/workspace/cloudfarming/src/picker
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh
OUT_DIR=runs/Picker

cd $OIGE_HOME

echo
echo "** reset all modifications..."
git checkout .

echo
echo "** clear untracked files..."
git clean -fd

echo
