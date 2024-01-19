#!/bin/bash

# -----------------------------------------------
# TEST ENVIRONMENT SETTINGS

# Set exit on any error:
set -e

# the shell file name only
SHELL_FILE=`echo $(basename $BASH_SOURCE)`
echo "SHELL_FILE=$SHELL_FILE"

# the shell file dir name
SHELL_DIR=$(cd "$(dirname "$BASH_SOURCE")";pwd)
echo "SHELL_DIR=${SHELL_DIR}"

# the shell file absolute
FILE_PATH=$SHELL_DIR/$SHELL_FILE
echo "FILE_PATH=${FILE_PATH}"

# since ccufuns already source comfuns.sh, here not need to source again? yes!
# source $SHELL_DIR/utils/comfuns.sh
source $SHELL_DIR/utils/ccufuns.sh

# TEST ENVIRONMENT SETTINGS
# -----------------------------------------------

# -----------------------------------------------
# TEST FUNCTIONS

function test_log()
{
    echo "[$FUNCNAME]: E..."
    logv this is $FILE_PATH logvvv
    logd this is $FILE_PATH logddd
    logi this is $FILE_PATH logiii
    logw this is $FILE_PATH logwww
    loge this is $FILE_PATH logeee
    echo "[$FUNCNAME]: X."
}

function test_get_ccu_ip()
{
    echo "[$FUNCNAME]: E..."
    # search_ip 192.168.1
    
    echo "get ccu ip..."
    get_ccu_ip
    if [ $? -ne 0 ]; then
        echo "get ccu ip failed"
    fi
    echo CCU_IP=$CCU_IP
    echo "[$FUNCNAME]: X."
}

function test_shell_dir_file()
{
    echo "[$FUNCNAME]: E..."
    
    SHELL_DIR1=`echo $(pwd)/$(dirname $BASH_SOURCE)`
    echo "** SHELL_DIR1 = $SHELL_DIR1"
    
    SHELL_DIR2=`cd $(dirname $BASH_SOURCE) && pwd`
    echo "** SHELL_DIR2 = $SHELL_DIR2"
    
    SHELL_FILE=`basename $BASH_SOURCE`
    echo "** SHELL_FILE = $SHELL_FILE"
    
    # bc2:scripts~$ source test2.sh
    # ** SHELL_DIR1 = /home/liz/ginger441/src/cr-tools/cmdex_tools/scripts//home/liz/ginger441/src/cr-tools/cmdex_tools/scripts
    # ** SHELL_DIR2 = /home/liz/ginger441/src/cr-tools/cmdex_tools/scripts
    
    # bc2:scripts~$ source ./test2.sh
    # ** SHELL_DIR1 = /home/liz/ginger441/src/cr-tools/cmdex_tools/scripts/.
    # ** SHELL_DIR2 = /home/liz/ginger441/src/cr-tools/cmdex_tools/scripts
    
    # so SHELL_DIR2( `cd $(dirname $BASH_SOURCE) && pwd` ) is ok!!!
    
    # echo "${BASH_SOURCE[0]}"
    # echo "${BASH_SOURCE}"
    # echo "$(dirname "${BASH_SOURCE[0]}")"
    # echo "$(cd "`${dirname $BASH_SOURCE}`" && pwd)"
    
    
    # files=$(ls $result_path1)
    # for filename in $files
    # do
    #    filename_noext=${filename%%.*}
    #    ext=${filename#*.}
    #    echo "process: $filename"
    #    echo $filename_noext
    # First, get file name without the path:
    # filename="(basename"fullfile")"
    # extension="${filename##*.}"
    # filename="${filename%.*}"
    # Alternatively, you can focus on the last '/' of the path instead of the '.' which should work even if you have unpredictable file extensions:
    # filename="${fullfile##*/}"
    #    echo $ext
    #    ffmpeg -i ./$result_path1/"$filename_noext.$ext" -i ./$result_path2/"$filename_noext.$ext"  -lavfi hstack=2 -y ./$concat_path/"concat-$filename_noext.mp4"
    # done
    
    echo "[$FUNCNAME]: X."
}

function test_date_time()
{
    echo "$(date +%s.%N) $(basename $0)/$LINENO - [$FUNCNAME]: begin..."
    echo "$(date '+%y-%m-%d %H:%M:%S.%03N') $(basename $0)/$LINENO - [$FUNCNAME]: success"
    
    # HEAD="echo $(date '+%y-%m-%d %H:%M:%S.%03N') $(basename $0)/$LINENO - [$FUNCNAME]"
    # echo "$HEAD: 111"  # not work, line no same
    # echo "$HEAD: 222"
    
    # HEAD_RAW="\$(date '+%y-%m-%d %H:%M:%S.%03N') \$(basename \$0)/\$LINENO - [\$FUNCNAME]"
    # HEAD=${HEAD_RAW//\$/$}
    # echo HEAD=$HEAD;
    # $HEAD
}

function _test_format_time()
{
    res=$(format_time $1)
    exp=$2
    if [ "$res" != "$exp" ]; then
        loge "ERROR: $FUNCNAME($1) failed, expect $exp but $res"
        exit -1
    fi
}

function test_format_time()
{
    echo "$(date '+%s.%03N') $(basename $0)/$LINENO - [$FUNCNAME]: begin..."
    _test_format_time 0 0.000
    _test_format_time 1 0.001
    _test_format_time 100 0.100
    _test_format_time 990 0.990
    _test_format_time 1000 1.000
    _test_format_time 3600 3.600
    _test_format_time 36100 36.100
    _test_format_time 361010 6:01.010
    _test_format_time 3600000 1:00:00.000
    _test_format_time 3600009 1:00:00.009
    _test_format_time 3600010 1:00:00.010
    _test_format_time 3600123 1:00:00.123
    _test_format_time 3600999 1:00:00.999
    _test_format_time 3610999 1:00:10.999
    _test_format_time 36000999 10:00:00.999
    _test_format_time 36100999 10:01:40.999
    echo "$(date '+%s.%03N') $(basename $0)/$LINENO - [$FUNCNAME]: success"
}

function test_calculate_time_diff()
{
    echo "$(date '+%s.%03N') $(basename $0)/$LINENO - [$FUNCNAME]: begin..."
    BEGIN_TIME=$(date +%s.%N)
    sleep 0.1s
    END_TIME=$(date +%s.%N)
    TIME_USED=$(calculate_time_diff $BEGIN_TIME $END_TIME)
    echo "time used: "$TIME_USED
    echo "$(date '+%s.%03N') $(basename $0)/$LINENO - [$FUNCNAME]: success"
}

function test_log_var()
{
    CMDEX_LOG_LEVEL=$CMDEX_LOG_D
    
    log_empty_line
    logi "[$FUNCNAME]: E..."
    
    APP_NAME=testssdfe
    logd_var APP_NAME
    logi_var APP_NAME
    
    APP_NAME2="fffas' this's is d"
    logd_var APP_NAME2
    
    APP_NAME3=123
    logd_var APP_NAME3
    
    APP_NAME4=$APP_NAME
    logd_var APP_NAME4
    
    APP_NAME5="$APP_NAME/fbb/ccc"
    logd_var APP_NAME5
    
    echo "test unset var..."
    logd_var UNSET_VAR
    
    echo "test no param..."
    logd_var
    
    logi "[$FUNCNAME]: X."
    log_empty_line
}

# TEST FUNCTIONS
# -----------------------------------------------

#------------------------------------------------------------------------------
# MAIN FUNC

# test_date_time
# test_format_time
# test_calculate_time_diff
test_log_var
