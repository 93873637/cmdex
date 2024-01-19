#!/bin/bash

echo "** CMDEX_HOME = $CMDEX_HOME"
if [ ! $CMDEX_HOME ];then
    echo "** CMDEX_HOME not set."
    return
fi

$CMDEX_HOME/sh/dotdir.sh ~/tmp
