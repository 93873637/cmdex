
PARAMS=""
PARAMS="$PARAMS task=Cartpole"

PARAMS="$PARAMS headless=True"

PARAMS="$PARAMS num_envs=1"
PARAMS="$PARAMS max_iterations=100"
PARAMS="$PARAMS horizon_length=100"
PARAMS="$PARAMS minibatch_size=100"

# PARAMS="$PARAMS dt=0.0005"

ott $PARAMS
