#!/bin/sh
##****************************************************************************
## File Name     :  svndiff_last.sh
## Author        :  yuliang.tao (yuliang.tao@bitmain.com)
## Created At    :  Mon 18 Feb 2019 03:21:24 PM CST
## Last Modified :  Mon 18 Feb 2019 03:25:23 PM CST
##
##****************************************************************************
## Description   :  Diff btween local version and last version on server.
##
##****************************************************************************
## Change History:  R0.1 2019-02-18 | Initial creation.
##
##****************************************************************************

if [ ! -e $1 ]; then
    echo "File $1 not existing!"
    exit 1
fi

last_rev=$(svn log $1 | /bin/grep -P '^r\d+' | sed -n '2p' | sed 's/^r\([0-9]\+\).*/\1/')

svn diff -r $last_rev $1
