#!/bin/bash

echo

#------------------------------------------------------------

if [ -z "$RVV_HOME" ]; then
    echo "ERROR: RVV_HOME not set, please set RVV_HOME to its package path, such as: "
    echo "export RVV_HOME=/home/liz/ginger441/src/cr-tools/robot_vision_viewer"
    echo
    exit -1
fi
# echo "** RVV_HOME='$RVV_HOME'"

#------------------------------------------------------------

SHELL_DIR=$(dirname $BASH_SOURCE)
# echo "SHELL_DIR=$SHELL_DIR"

DETECT_NOARG_OPTIONS="info, on, off, zero, 0, reset"
DETECT_OPTIONS="$DETECT_NOARG_OPTIONS, size_x, sx, size_y, sy, center_x, cx, center_y, cy, depth_min, dmin, depth_max, dmax"

cd $SHELL_DIR
source __ginger_utils.sh

function usage() {
    echo
    echo "Usage: "
    echo "$(basename $0) <rvv-option>"
    echo
    echo "--rvv options:"
    echo "*   help/h - show this usage"
    echo "*  build/b - build rvv"
    echo "* launch/l - start rvv"
    echo "*       bl - build and launch rvv"
    echo "*    start - same as launch"
    echo "*     stop - kill rvv process"
    echo "*     info - show rvv info"
    echo "*     list - list rvv ctrl cmds"
    echo "*     ctrl - run rvv ctrl cmds which show by list, example:"
    echo "             rvv ctrl <cmd[:param]...>"
    echo "*   stream - turn on/off pcd stream publish, example:"
    echo "             rvv stream <on/off>"
    echo "*   detect - set calib target detection options as following:"
    echo "             [             on ]: start target detection"
    echo "             [            off ]: stop target detection"
    echo "             [         zero/0 ]: set current pose as detection zero pose"
    echo "             [          reset ]: reset detection range as default value"
    echo "             [      size_x/sx ]: set detect bbox size x by pixel"
    echo "             [      size_y/sy ]: set detect bbox size y by pixel"
    echo "             [    center_x/cx ]: set detect bbox center x by pixel"
    echo "             [    center_y/cy ]: set detect bbox center y by pixel"
    echo "             [ depth_min/dmin ]: set detect target depth min by meter"
    echo "             [ depth_max/dmax ]: set detect target depth max by meter"
    echo "*    calib - record or calibrate on given pose-index, format as:"
    echo "             rvv calib record <pose-index> -- record calibration files on <pose-index>"
    echo "             rvv calib <pose-index> -- calibrate on <pose-index>"
    echo
}

# check params
if [ $# -eq 0 ]; then
    usage
    exit -1
fi
OPT=$1
# echo "** OPT='$OPT'"

cd $RVV_HOME

case $OPT in
help | h) usage ;;
build | b) ./b.sh ;;
launch | l) ./l.sh ;;
bl) ./bl.sh ;;
start) ./l.sh ;;
stop) $SHELL_DIR/rvv_stop.sh ;;
list)
    usage
    source build/devel/setup.bash
    run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'list'\""
    ;;
info)
    source build/devel/setup.bash
    run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'info'\""
    ;;
ctrl)
    if [ $# -lt 2 ]; then
        echo "ERROR: No ctrl opt, please select one from following message:"
        source build/devel/setup.bash
        rosservice call /robot_vision_viewer/ctrl "data: 'list'"
    else
        source build/devel/setup.bash
        run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: '$2'\""
    fi
    ;;
stream)
    if [ $# -lt 2 ]; then
        echo "ERROR: No stream options, please select: on/off"
    else
        source build/devel/setup.bash
        run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'stream:$2'\""
    fi
    ;;
detect)
    if [ $# -lt 2 ]; then
        echo "ERROR: No enough params, format as:"
        echo "  rvv detect <$DETECT_OPTIONS> [value]"
    else
        echo "DETECT_NOARG_OPTIONS=$DETECT_NOARG_OPTIONS"
        if [[ "$DETECT_NOARG_OPTIONS" == *"$2"* ]]; then
            # no arg, run directly
            source build/devel/setup.bash
            run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'detect:$2'\""
        else
            # need arg of value
            if [ $# -lt 3 ]; then
                echo "ERROR: No detect value for option '$2'"
            else
                source build/devel/setup.bash
                run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'detect:$2:$3'\""
            fi
        fi
    fi
    ;;
calib)
    if [ $# -lt 2 ]; then
        echo "ERROR: No enough params, format as: rvv calib [record] <pose-index>"
    else
        if [ "$2" == "record" ]; then
            # record calibration file of pose
            if [ $# -lt 3 ]; then
                echo "ERROR: No pose-index to record calibration file"
            else
                source build/devel/setup.bash
                run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: 'record:$3'\""
            fi
        else
            # calibrate on pose
            source build/devel/setup.bash
            run_cmd "rosservice call /robot_vision_viewer/calib \"pose_index: $2\""
        fi
    fi
    ;;
*)
    echo "NOTE: No default rvv option '$OPT' found, try ctrl cmd..."
    source build/devel/setup.bash
    run_cmd "rosservice call /robot_vision_viewer/ctrl \"data: '$OPT'\""
    exit -2
    ;;
esac

echo
