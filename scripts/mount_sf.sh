#!/bin/bash 

if [ "$1" == "-u" ] ; then
    echo "Umounting /mnt/sf_SvShare..."
    umount -f /mnt/sf_SvShare
else
    echo "Mounting SvShare to /mnt/sf_SvShare..."
    mount -t vboxsf SvShare /mnt/sf_SvShare
fi

