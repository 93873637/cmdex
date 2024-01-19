#!/bin/bash

SETUP_DEBUG=false

function setup_debug() {
    if $SETUP_DEBUG; then
        echo "$*"
    fi
}

function setup_info() {
    echo "$*"
}

#
# NOTE:
# Run 'source setup.sh' first to use command extensions 'cx'
#

# -----------------------------------------------

# NOTE: using different name of ORIGIN_DIR_xxx in case conflict
ORIGIN_DIR_SETUP=$(echo $(pwd))
setup_debug "** ORIGIN_DIR_SETUP = [$ORIGIN_DIR_SETUP]"

setup_debug "** BASH_SOURCE = [$BASH_SOURCE]"

# the shell file name only
SHELL_FILE=$(echo $(basename $BASH_SOURCE))
setup_debug "** SHELL_FILE = [$SHELL_FILE]"

# the shell file dir name
SHELL_DIR=$(
    cd "$(dirname "$BASH_SOURCE")"
    pwd
)
setup_debug "** SHELL_DIR = [${SHELL_DIR}]"

# the shell file absolute
FILE_PATH=$SHELL_DIR/$SHELL_FILE
setup_debug "** FILE_PATH = [${FILE_PATH}]"

# -----------------------------------------------

cd $SHELL_DIR
source sh/utils/comfuns.sh

# -----------------------------------------------
# set CMDEX_HOME, remove old if exist

# NOTE: we need retrieve old CMDEX_HOME first
CMDEX_HOME_OLD=$CMDEX_HOME
setup_debug "** CMDEX_HOME_OLD = [$CMDEX_HOME_OLD]"

# set new CMDEX_HOME with the shell's directory
CMDEX_HOME=$SHELL_DIR
setup_debug "** CMDEX_HOME = [$CMDEX_HOME]"

# remove old settings from ~/.bashrc if exist
if [ "$CMDEX_HOME_OLD" != "" ] && [ "$CMDEX_HOME" != "$CMDEX_HOME_OLD" ]; then
    setup_debug "find old cmdex home '$CMDEX_HOME_OLD', while new '$CMDEX_HOME'"
    for (( ; ; )); do
        # check and remove old cmdex_tools in ~/.bashrc
        OLD_LINE=$(awk "/cmdex_tools\/scripts\//{ print NR; exit }" ~/.bashrc)
        if [ -z "$OLD_LINE" ]; then
            # logd "No cmdex_tools set found on ~/.bashrc"
            break
        else
            echo "NOTE: find old cmdex_tools set at line $OLD_LINE of ~/.bashrc, remove..."
            sed "${OLD_LINE}d" ~/.bashrc >temp && mv temp ~/.bashrc
        fi

        # check and remove old cmdex_tools in ~/.bashrc either
        OLD_LINE=$(awk "/cmdex_tools\/scripts\//{ print NR; exit }" ~/.bashrc)
        if [ -z "$OLD_LINE" ]; then
            # logd "No cmdex_tools set found on ~/.bashrc"
            break
        else
            echo "NOTE: find old cmdex_tools set at line $OLD_LINE of ~/.bashrc, remove..."
            sed "${OLD_LINE}d" ~/.bashrc >temp && mv temp ~/.bashrc
        fi
    done
fi
# -----------------------------------------------

# set cmdex env variables
export CMDEX_HOME=${CMDEX_HOME}
export PATH=${CMDEX_HOME}:${CMDEX_HOME}/sh:$PATH

#--------------------------------------------------
# setup_debug "-- set cmdex.sh -> cx link..."
# setlink cmdex.sh cx

cd sh

# set sh files to exec first
setup_debug "-- chmod +x on shell files..."
source cx_exe_i.sh

setup_debug "-- set cmdex links..."
setlink $CMDEX_HOME/cmdex.sh cx
source $CMDEX_HOME/sh/__setlink.sh
#--------------------------------------------------

source $CMDEX_HOME/sh/__extensions.sh
setup_extensions

#--------------------------------------------------
# Add to .bashrc to take effect on login
#
SOURCE_SETUP="source ${FILE_PATH}"
setup_debug "** SOURCE_SETUP = [$SOURCE_SETUP]"

CHECK_SETUP=$(grep "${SOURCE_SETUP}" ~/.bashrc)
setup_debug "** CHECK_SETUP = [$CHECK_SETUP]"

if [ -z "$CHECK_SETUP" ]; then
    echo "[cx]: cmdex env setup..."
    echo ${SOURCE_SETUP} >>~/.bashrc
fi

echo "[cx]: cmdex ready"
#--------------------------------------------------

# restore original dir
cd $ORIGIN_DIR_SETUP
