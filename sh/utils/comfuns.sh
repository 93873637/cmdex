#!/bin/bash

#
# COM FUNCTIONS
#

# -----------------------------------------------------------------------------------
# COLOR DEFs

# https://www.zhangshengrong.com/p/rG1V7pEJa3/
# \033[显示方式; 前景色; 背景色 m
# 显示方式:0（默认值）、1（高亮）、22（非粗体）、4（下划线）、24（非下划线）、5（闪烁）、25（非闪烁）、7（反显）、27（非反显）
# 前景色:30（黑色）、31（红色）、32（绿色）、 33（黄色）、34（蓝色）、35（洋红）、36（青色）、37（白色）
# 背景色:40（黑色）、41（红色）、42（绿色）、 43（黄色）、44（蓝色）、45（洋红）、46（青色）、47（白色）
# 记得在打印完之后，把颜色恢复成默认（\033[0m），不然再后面的打印都会跟着变色。
#define BOLD     "\e[1m"
#define UNDERLINE   "\e[4m"
#define BLINK    "\e[5m"
#define REVERSE    "\e[7m"
#define HIDE     "\e[8m"
#define CLEAR    "\e[2J"
#define CLRLINE    "\r\e[K" //or "\e[1K\r"

COLOR_NONE="\e[0m"
COLOR_END="\e[0m"

COLOR_BLACK="\e[0;30m"
COLOR_BLACK_LIGHT="\e[1;30m"

COLOR_RED="\e[0;31m"
COLOR_RED_LIGHT="\e[1;31m"

COLOR_GREEN="\e[0;32m"
COLOR_GREEN_LIGHT="\e[1;32m"

COLOR_BROWN="\e[0;33m"
COLOR_YELLOW="\e[1;33m"

COLOR_BLUE="\e[0;34m"
COLOR_BLUE_LIGHT="\e[1;34m"

COLOR_PURPLE="\e[0;35m"
COLOR_PURPLE_LIGHT="\e[1;35m"

COLOR_CYAN="\e[0;36m"
COLOR_CYAN_LIGHT="\e[1;36m"

COLOR_GRAY="\e[0;37m"
COLOR_WHITE="\e[1;37m"

# red) echo -e "\e[1;31m$color $str \e[0m";;
# green) echo -e "\e[1;32m$color $str \e[0m";;
# yellow) echo -e "\e[1;33m$color $str \e[0m";;
# blue) echo -e "\e[1;34m$color $str \e[0m";;
# *) echo -e "\e[1;30m这是什么颜色?\e[0m";;

# COLOR DEFs
# -----------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------
# PRINT DEFs

function print_color()
{
    # echo 1=$1
    # echo 2=$2
    # echo n=$#
    if [ $# -ge 2 ];then
        echo -e "$1${*:2}$COLOR_END"
    fi
}

function print_cyan()
{
    print_color $COLOR_CYAN "$*"
}

function print_green()
{
    print_color $COLOR_GREEN "$*"
}

function print_yellow()
{
    print_color $COLOR_YELLOW "$*"
}

function print_red()
{
    print_color $COLOR_RED "$*"
}

function print_white()
{
    print_color $COLOR_WHITE "$*"
}

function print_info()
{
    print_white "$*"
}

function print_error()
{
    print_red "$*"
}

# PRINT DEFs
# -----------------------------------------------------------------------------------

# -----------------------------------------------------------------------------------
# LOG DEFs

# set CMDEX_LOG_LEVEL to open log, such as:
# export CMDEX_LOG_LEVEL=2
# to open debug log output

CMDEX_LOG_NONE=0

CMDEX_LOG_E=1
CMDEX_LOG_W=2
CMDEX_LOG_I=3
CMDEX_LOG_D=4
CMDEX_LOG_V=5

CMDEX_LOG_DEFAULT=$CMDEX_LOG_I

function loge()
{
    if [[ -z "$CMDEX_LOG_LEVEL" || $CMDEX_LOG_LEVEL -ge $CMDEX_LOG_E ]]; then
        print_red "$*"
    fi
}

function logw()
{
    if [[ -z "$CMDEX_LOG_LEVEL" || $CMDEX_LOG_LEVEL -ge $CMDEX_LOG_W ]]; then
        print_yellow "$*"
    fi
}

function logi()
{
    # print_green "** CMDEX_LOG_LEVEL=[$CMDEX_LOG_LEVEL]"
    if [[ -z "$CMDEX_LOG_LEVEL" || $CMDEX_LOG_LEVEL -ge $CMDEX_LOG_I ]]; then
        print_white "$*"
    fi
}

function logd()
{
    if [[ ! -z "$CMDEX_LOG_LEVEL" && $CMDEX_LOG_LEVEL -ge $CMDEX_LOG_D ]]; then
        print_green "$*"
    fi
}

function logv()
{
    if [[ ! -z "$CMDEX_LOG_LEVEL" && $CMDEX_LOG_LEVEL -ge $CMDEX_LOG_V ]]; then
        print_cyan "$*"
    fi
}

function logd_var()
{
    if [ $# -gt 0 ]; then
        logd "** $1=[$(eval echo \"\$$1\")]"
    fi
}

function logi_var()
{
    if [ $# -gt 0 ]; then
        logi "** $1=[$(eval echo \"\$$1\")]"
    fi
}

function log_empty_line()
{
    echo
}

# LOG DEFs
# -----------------------------------------------------------------------------------

function run_cmd()
{
    print_info "[CMD]:"
    print_info $*
    bash -c "$*"
}

function touch_dir_and_enter()
{
    mkdir -p $1 && cd $1
}

function compare_file()
{
    if [ $# -ne 2 ];then
        print_error "[usage]: compare_file filepath1 filepath2"
        return -1
    fi
    echo
    echo "[compare_file]: $1 vs. $2..."
    ls -l $1
    ls -l $2
    diff $1 $2 > /dev/null
    if [ $? == 0 ]; then
        print_green "[compare_file]: --SAME--"  # NOTE: don't use '*', or func exception
        return 0
    else
        print_yellow "[compare_file]: --DIFF--"
        return 1
    fi
}

function sync_file()
{
    if [ $# -ne 2 ];then
        print_error "[usage]: $0 filepath1 filepath2"
        return -1
    fi
    echo
    echo "[sync_file]: $1 -> $2..."
    cp -rf $1 $2
    compare_file $1 $2
    if [ $? == 0 ]; then
        print_green "[sync_file]: success"
        return 0
    else
        print_error "[sync_file]: failed"
        return 1
    fi
}

function sync_dir()
{
    if [ $# -ne 2 ];then
        print_error "[usage]: $0 dir1 dir2"
        return -1
    fi
    echo
    echo "[sync_dir]: $1 -> $2..."
    
    rm -rf $2
    if [ $? != 0 ]; then
        print_error "[sync_file]: remove old dir '$2' failed."
        return -2
    fi
    
    cp -rf $1 $2
    if [ $? != 0 ]; then
        print_error "[sync_file]: copy new dir failed."
        return -3
    fi
    
    DIFF=`diff -ruNaq $1 $2`
    if [ ! -z "$DIFF" ]; then
        print_error "[sync_dir]: dir not same after copy"
        echo $DIFF
        return -4
    fi
    
    print_green "[sync_dir]: success"
    return 0
}

function tar_log_ts()
{
    LOG_NAME=$1
    LOG_SRC=$2
    LOG_DIR=$3
    
    if [ ! -d "${LOG_SRC}" ]; then
        echo "ERROR: log src '${LOG_SRC}' not exists"
        echo
        exit -1
    fi
    
    echo "-- LOG_DIR=${LOG_DIR}"
    if [ ! -d "${LOG_DIR}" ]; then
        echo "-- log dir '${LOG_DIR}' not exists, create..."
        mkdir -p ${LOG_DIR}
    fi
    
    LOG_FILE=${LOG_DIR}/${LOG_NAME}_${CUR_DATE_TIME}.tar.gz
    echo "-- LOG_FILE=${LOG_FILE}"
    
    echo "-- tar ${LOG_SRC} -> ${LOG_FILE}..."
    cd ${LOG_SRC}
    tar zcvf ${LOG_FILE} *
    if [ $? -ne 0 ]; then
        echo "tar failed."
        echo
        exit -1
    fi
    echo
    
    echo "-- $LOG_NAME saved to ${LOG_FILE}."
    ls -lh ${LOG_FILE}
    echo
}

function print_var() {
    var=`eval echo '$'"$1"`
    echo $1=$var
}

function setlink()
{
    LINK_TARGET=$1
    LINK_FILE=$2
    rm -rf $LINK_FILE
    ln -s $LINK_TARGET $LINK_FILE
    # echo "setlink: $LINK_FILE -> $LINK_TARGET"
}

#
# check if given ip address has valid format
#
# you can test with following codes:
# while true; do
#     read -p "Please enter IP: " IP
#     check_ip $IP
#     [ $? -eq 0 ] && break
# done
#
function ip_format_check()
{
    local IP=$1
    VALID_CHECK=$(echo $IP|awk -F. '$1<=255&&$2<=255&&$3<=255&&$4<=255{print "yes"}')
    if echo $IP|grep -E "^[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}$" >/dev/null; then
        if [ $VALID_CHECK == "yes" ]; then
            echo "IP $IP  available!"
            return 0
        else
            echo "IP $IP not available!"
            return 1
        fi
    else
        echo "IP format error!"
        return 1
    fi
}

#
# check if ip address valid on current network
#
# [PARAM REQ]
# $1: ip address to check
#
function check_ip()
{
    ping -c 1 -W 1 $1 &> /dev/null
    if [ $? -ne 0 ];then
        return -1
    else
        return 0
    fi
}

#
# search ip addresses on given netmask
#
# [PARAM REQ]
# $1: netmask address, such as '192.168.1'
#
function search_ip()
{
    if [ $# -ne 1 ];then
        print_error "[usage]: $1 netmask-address"
        return -1
    fi
    echo "** search on address $1.*..."
    
    total=0
    success=0
    failed=0
    for i in $1.{1..254}
    do
        total=$(($total + 1))
        check_ip $i
        if [ $? -ne 0 ]; then
            failed=$(($failed + 1))
            echo "[CHECK #$total ($success/$failed)]: $i failed"
        else
            success=$(($success + 1))
            echo "[CHECK #$total ($success/$failed)]: success!!! ----------> $i"
        fi
        sleep 1s # add sleep for ctrl-c exit
    done
    
    echo
    echo "** search over, total $total, success $success, failed $failed."
    echo
}

#
# set on ctrl-c exit in case some unresponse loop
# just call set_on_ctrl_c_exit is ok
#
function on_ctrl_c_exit ()
{
    echo 'Ctrl+C captured'
    exit 2
}

function set_on_ctrl_c_exit()
{
    trap 'on_ctrl_c_exit' INT
}

#
# Format robot_vision c/c++ files as Google style
#
# NOTE:
# First install clang-format by:
# sudo apt install clang-format
#
function format_cpp_code()
{
    if [ $# -lt 2 ]; then
        echo "Usage: $FUNCNAME <file-path> <code-style>"
        return
    fi
    FILE_PATH=$1
    echo "$FILE_PATH"
    CODE_STYLE=$2
    # echo "$CODE_STYLE"
    
    clang-format -style="$CODE_STYLE" $FILE_PATH > $FILE_PATH.tmp
    mv $FILE_PATH.tmp $FILE_PATH
}

function format_cpp_code_on_dir()
{
    if [ $# -lt 2 ]; then
        echo "Usage: $FUNCNAME <src-dir> <code-style>"
        return
    fi
    SRC_DIR=$1
    CODE_STYLE=$2
    echo "FORMAT ON DIR: $SRC_DIR"
    echo "CODE_STYLE: $CODE_STYLE"
    echo
    
    FILE_COUNT=0
    fileList=`find $SRC_DIR -name "*.h" -o -name "*.hpp" -o -name "*.c" -o -name "*.cc" -o -name "*.cpp"`
    for fileName in $fileList;
    do
        format_cpp_code $fileName "$CODE_STYLE"
        ((FILE_COUNT=FILE_COUNT+1))
    done
    
    echo
    echo "$FILE_COUNT files formatted."
    echo
}

function check_ros()
{
    if [ ! -z $ROS_DISTRO ]; then
        echo "** ROS_DISTRO: $ROS_DISTRO"
        return 0
    fi
    
    # try set ros version if exist
    ROS_NOETIC=/opt/ros/noetic/setup.bash
    ROS_MELODIC=/opt/ros/melodic/setup.bash
    if [ -f $ROS_NOETIC ];
    then
        source $ROS_NOETIC
    elif [ -f $ROS_MELODIC ];
    then
        source $ROS_MELODIC
    else
        echo "ERROR: NO support ros version found."
        return -1
    fi
    
    if [ -z $ROS_DISTRO ]; then
        echo "ERROR: set ros version failed."
        return -1
    else
        echo "** set ros version: $ROS_DISTRO"
        return 0
    fi
}

#
# Usage:
#
# echo "$(format_time 12345)"
#
function format_time()
{
    if [ $# -lt 1 ]; then
        echo "NoTime"
        return
    fi
    
    ms=$1
    # echo "ms=$ms"
    
    hh=$[ $ms / (60*60*1000) ]
    ms=$[ $ms - $[ $hh*(60*60*1000) ]]
    # echo "hh=$hh"
    # echo "ms=$ms"
    
    mm=$[ $ms / (60*1000) ]
    ms=$[ $ms - $[ $mm*(60*1000) ]]
    if [ $mm -ge 10 ]; then
        # echo "mm < 10"
        mms=$mm
    else
        mms=0$mm
    fi
    # echo "mm=$mm"
    # echo "ms=$ms"
    
    ss=$[ $ms / 1000 ]
    ms=$[ $ms - $[ $ss*1000 ]]
    if [ $ss -ge 10 ]; then
        sss=$ss
    else
        sss=0$ss
    fi
    # echo "ss=$ss"
    # echo "ms=$ms"
    
    if [ $ms -ge 100 ]; then
        mss=$ms
    elif [ $ms -ge 10 ];
    then
        mss=0$ms
    else
        mss=00$ms
    fi
    
    # echo "$1 -> $hh:$mm:$ss.$ms"
    if [ $hh -gt 0 ]; then
        echo "$hh:$mms:$sss.$mss"
    elif [ $mm -gt 0 ];
    then
        echo "$mm:$sss.$mss"
    else
        echo "$ss.$mss"
    fi
}

#
# Usage:
#
# BEGIN_TIME=$(date +%s.%N)
# # do something...
# END_TIME=$(date +%s.%N)
# TIME_USED=$(time_check_diff $BEGIN_TIME $END_TIME)
# echo "time used: "$TIME_USED
#
function calculate_time_diff()
{
    time1=$1
    time2=$2
    start_s=$(echo $time1 | cut -d '.' -f 1)
    start_ns=$(echo $time1 | cut -d '.' -f 2)
    end_s=$(echo $time2 | cut -d '.' -f 1)
    end_ns=$(echo $time2 | cut -d '.' -f 2)
    time_ms=$(((10#$end_s - 10#$start_s) * 1000 + (10#$end_ns / 1000000 - 10#$start_ns / 1000000)))
    echo "$(format_time $time_ms)"
}

# -----------------------------------------------------------------------------------
# Time Check Functions

function time_check_begin()
{
    TC_BEGIN_TIME=$(date +%s.%N)
    TC_LAST_TIME=$TC_BEGIN_TIME
    TC_CHECK_COUNT=0
    echo "[TC BEGIN]"
}

function time_check_diff()
{
    if [ "$#" -ne 2 ]; then
        echo "NaN"
        return
    fi
    start_s=$(echo $1 | cut -d '.' -f 1)
    start_ns=$(echo $1 | cut -d '.' -f 2)
    end_s=$(echo $2 | cut -d '.' -f 1)
    end_ns=$(echo $2 | cut -d '.' -f 2)
    time_ms=$(((10#$end_s - 10#$start_s) * 1000 + (10#$end_ns / 1000000 - 10#$start_ns / 1000000)))
    time_s=$(((10#$time_ms/1000)))
    echo "${time_s}.${time_ms:0:3}s"
}

function time_check()
{
    TC_CURRENT_TIME=$(date +%s.%N)
    check_s=$(echo $TC_CURRENT_TIME | cut -d '.' -f 1)  # get second
    check_ns=$(echo $TC_CURRENT_TIME | cut -d '.' -f 2)  # get nano-second
    
    # calculate time diff from last
    diff_time=$(time_check_diff $TC_LAST_TIME $TC_CURRENT_TIME)
    
    # calculate total time from start
    total_time=$(time_check_diff $TC_BEGIN_TIME $TC_CURRENT_TIME)
    
    TC_LAST_TIME=$TC_CURRENT_TIME
    ((TC_CHECK_COUNT=TC_CHECK_COUNT+1))
    echo "[TC CHECK #$TC_CHECK_COUNT]: $total_time +$diff_time"
}

# Time Check Functions
# -----------------------------------------------------------------------------------

function kill_process_by_name()
{
    if [ $# -ne 1 ];then
        print_error "[usage]: $FUNCNAME <process-name>"
        return -1
    fi
    
    PROCESS_NAME=$1
    
    echo "** kill process by name '$PROCESS_NAME'..."
    COUNT=0
    MAX_COUNT=100
    while [ $COUNT -lt $MAX_COUNT ]
    do
        let COUNT++
        PID=`ps -efw | grep ${PROCESS_NAME} | grep -v grep | grep -v $$ | awk '{print $2}'`
        if [ "$PID" = "" ]; then
            echo "#$COUNT/$MAX_COUNT: $PROCESS_NAME pid not found."
            break
        else
            echo "#$COUNT/$MAX_COUNT: find $PROCESS_NAME's pid $PID, kill it..."
            sudo kill -9 $PID
        fi
        
        # wait some time to check...
        WAIT_TIME=2s
        echo
        echo "#$COUNT/$MAX_COUNT: wait ${WAIT_TIME}s to check..."
        sleep ${WAIT_TIME}
    done
    
    echo "#$COUNT/$MAX_COUNT: kill process by name '$PROCESS_NAME' success"
    return 0
}
