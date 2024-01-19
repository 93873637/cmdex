#!/bin/bash

OIGE_HOME=/home/tomli/workspace/isaacsim/OmniIsaacGymEnvs/omniisaacgymenvs
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh

cd $OIGE_HOME
CMD="$OIGE_PYTHON scripts/random_policy.py num_envs=1 $*"
echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD

