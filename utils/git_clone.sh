#!/bin/bash

# taoyl, created at Tue Dec 20 13:09:33 CST 2016

# TODO: use arguments to set them.
# Global settings, default for NanoAP

# usage
function usage () {
    echo "Usage: ${0##*/} -r|--remote REMOTE [-l|--local LOCAL_DIR] [-h|--help]" | lolcat
    exit 1
}

ARGS=`getopt -u -o "r:l:h" -l "remote:,local:,help" -- "$@"`
# check if getopt return value
[ $? -ne 0 ] && usage
# reorder arguments
set -- ${ARGS}

#default settings
local_name=""

while [ true ]; do 
    case $1 in 
        -r|--remote)
            remote_name="$2"; shift;;
        -l|--local)
            local_name="$2"; shift;;
        -h|--help)
            usage; break;;
        --)
            shift; break;;
        *)
            echo "**Usage error!"
            usage;;
    esac
    shift
done

# sanity checks
if [ ! -n "$remote_name" ]; then
    echo "** No remote repos specified"
    usage
fi

git clone git@sv-gitlab:sv/${remote_name}.git $local_name
