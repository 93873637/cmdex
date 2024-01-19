# refer to:
# https://github.com/NVIDIA-Omniverse/OmniIsaacGymEnvs



OIGE_HOME=/home/tomli/workspace/isaacsim/OmniIsaacGymEnvs/omniisaacgymenvs
OIGE_PYTHON=/home/tomli/.local/share/ov/pkg/isaac_sim-2022.2.1/python.sh

cd $OIGE_HOME
CMD="$OIGE_PYTHON scripts/rlgames_demo.py"
CMD="$CMD task=AnymalTerrain num_envs=64"
CMD="$CMD checkpoint=omniverse://localhost/NVIDIA/Assets/Isaac/2023.1.1/Isaac/Samples/OmniIsaacGymEnvs/Checkpoints/anymal_terrain.pth"

echo
echo "** RUN COMMAND:"
echo "~~~~~~~~~~~~~~~~~~~"
echo $CMD
echo "~~~~~~~~~~~~~~~~~~~"
echo
$CMD
