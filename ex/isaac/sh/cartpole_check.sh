PARAMS=""
PARAMS="$PARAMS task=Cartpole"
PARAMS="$PARAMS checkpoint=runs/Cartpole/nn/Cartpole.pth"

# note: set dt and matched episode_length
PARAMS="$PARAMS episode_length=300"
PARAMS="$PARAMS dt=0.002"

otc $PARAMS
