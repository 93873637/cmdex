#!/bin/bash

echo ""
if [ $# -eq 0 ]; then
    DOT_FILE_DIR=.
else
    DOT_FILE_DIR=$1
fi
echo "** DOT_FILE_DIR=$DOT_FILE_DIR"
cd $DOT_FILE_DIR

DOT_FILE_EXT=dot
COUNT=0
for file in `ls $DOT_FILE_DIR`
do
    if [ -f "$DOT_FILE_DIR/$file" ]
    then
        if [[ $file == *.$DOT_FILE_EXT ]]
        then
            dot -Tpng $file > $file.png
            let COUNT++
            echo "-- dot file: $file -> $file.png"
        fi
    fi
done
echo "** DOT OVER, FILE NUM: $COUNT"
echo ""

if [ $COUNT -gt 0 ]; then
    echo "** Remove dot files..."
    rm -rf *.dot
    echo "** List png files..."
    ls -l $DOT_FILE_DIR/*.png
    echo ""
fi
