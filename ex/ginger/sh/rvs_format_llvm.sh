#!/bin/bash

SRC_DIR=/home/kevin/work/nx441_dev/packages/apps/robot_vision/rtsp_video_server
CODE_STYLE="{ BasedOnStyle: LLVM, UseTab: Never, IndentWidth: 4, TabWidth: 4, BreakBeforeBraces: Allman, AllowShortIfStatementsOnASingleLine: false, IndentCaseLabels: false, ColumnLimit: 120, AccessModifierOffset: -4 }"

# go to this shell's current directory
SHELL_DIR=$(cd $(dirname $BASH_SOURCE) && pwd)
# echo "** SHELL_DIR=$SHELL_DIR"

source $SHELL_DIR/__ginger_utils.sh
format_cpp_code_on_dir $SRC_DIR "$CODE_STYLE"
