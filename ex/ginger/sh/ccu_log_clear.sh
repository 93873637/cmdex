#!/bin/bash

# --------------------------------------------------------
# set variables

CCU_LOG=/home/ginger/ginger_logs

# --------------------------------------------------------

THIS_FILE=`echo $(basename $BASH_SOURCE)`
echo "THIS_FILE=${THIS_FILE}"

echo

echo "[ ${THIS_FILE} ]: BEFORE clear, ${CCU_LOG}:"
ls -l ${CCU_LOG}
echo

echo "[ ${THIS_FILE} ]: size of ${CCU_LOG}: "
du -sh ${CCU_LOG}
echo

echo "[ ${THIS_FILE} ]: clear ccu logs..."
sudo rm -rf ${CCU_LOG}/*
echo

echo "[ ${THIS_FILE} ]: AFTER clear, ${CCU_LOG}:"
ls -l ${CCU_LOG}
echo
