#!/bin/bash

# cd the shell's dir
SHELL_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)
cd $SHELL_DIR

./kill_module.sh robot_vision_location
