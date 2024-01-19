#!/bin/bash

# rol.sh: Run cmd, Output to screen, and Log to file at same time

function usage() {
    echo "
Usage:
  $0 cmd_string_or_shell_file_name
    "
}

LOG_DIR=log

if [ $# -eq 0 ];then
    usage
    exit
fi

if [ ! -d "${LOG_DIR}" ];then
    mkdir ${LOG_DIR}
fi

CMD=$1
FILE_PREFIX=`basename $1`

DATE=`date +%y.%m%d.%H%M%S`
LOG_FILE=./${LOG_DIR}/${FILE_PREFIX}_${DATE}.log

FULL_CMD="stdbuf -oL -eL ${CMD} >&1 | tee ${LOG_FILE}"
echo ""
echo ${FULL_CMD}
echo ""
stdbuf -oL -eL ${CMD} >&1 | tee ${LOG_FILE}
