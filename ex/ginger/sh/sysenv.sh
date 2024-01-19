#!/bin/bash

function print_var() {
    var=`eval echo '$'"$1"`
    echo $1=$var
}

print_var GST_PLUGIN_PATH
print_var GST_DEBUG_DUMP_DOT_DIR
print_var GST_DEBUG
