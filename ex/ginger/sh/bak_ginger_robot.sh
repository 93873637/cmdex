#!/bin/bash

cd ~
if [ ! -d "tmp" ];then
    mkdir tmp
fi

DATE=`date +%y.%m%d.%H%M%S`
BAK_FILE=~/tmp/ginger_robot_${DATE}.tar.gz

tar zcvf ${BAK_FILE} /vendor/ginger_robot/ /ftm/

ls -l ${BAK_FILE}
