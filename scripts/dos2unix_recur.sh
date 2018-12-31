#!/bin/bash

if [ "$1" == "-d" ]; then
    if [ "$2" != "" ]; then
        target_dir=$2
        echo "Target working directory: $target_dir"
    else
        echo "Must specify a directory"
    fi
else
    echo "**Incorrect usage!"
    echo "dos2unix_recur.sh -d dir"
fi


function change_file_format() {
    local dir=$1
    echo "Entering $dir..."
    cd $dir
    for fd in `ls`
    do
        if [ -d $fd ]; then
            change_file_format $fd
        else
            echo "Processing file: $fd"
            dos2unix $fd
        fi
    done
    echo "Exiting $dir..."
    cd ..
}
         

change_file_format $target_dir
    
