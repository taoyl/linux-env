#!/bin/bash

# Host setup for NVMe test
# taoyl, created at Fri Dec  1 14:54:46 CST 2017

# Global settings, default for NanoAP

# usage
function usage () {
    echo "Usage: ${0##*/} [-r|--install] [-h|--help]"
    exit 1
}

function check_pass () {
    echo
    echo "[ok] all checks pass"
    exit 0
}


ARGS=`getopt -u -o "ih" -l "install,help" -- "$@"`
# check if getopt return value
[ $? -ne 0 ] && usage
# reorder arguments
set -- ${ARGS}

#default settings
install=0

while [ true ]; do 
    case $1 in 
        -i|--install)
            install=1;;
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

#----------------------------------------------------------------------------
# check if nvme driver exists
#----------------------------------------------------------------------------
kernel=`uname -a | cut -d' ' -f3`
echo "host kernel=$kernel"
driver_path="/lib/modules/$kernel/kernel/drivers"
if [ "$(find $driver_path -name 'nvme.ko')" != "" ]; then
    echo "[ok] nvme driver check pass"
else
    echo "** No nvme driver found"
    exit 1
fi

#----------------------------------------------------------------------------
# check python version
#----------------------------------------------------------------------------
py_version=`python3 -V`
py_ver_m=`python3 -V | cut -d' ' -f2 | cut -d'.' -f1`
if [ "$py_ver_m" != "3" ]; then
    echo "*** No python3 found"
    if [ $install -ne 1 ]; then
        exit 1
    fi
    echo "Installing python3..."
    sudo apt-get install -y python3
    sudo apt-get install -y python3-pip
else
    echo "[ok] python version check pass: $py_version"
fi

#----------------------------------------------------------------------------
# check nose
#----------------------------------------------------------------------------
#nose_version=`pip3 list | grep '\<nose\>' | sed 's/[()]//g'`
#if [ "$nose_version" == "" ]; then
nose_installed=`python3 -c "import nose" 2>&1 | grep 'ImportError'`
if [ "$nose_installed" != "" ]; then
    echo "** No python-nose found"
    if [ $install -ne 1 ]; then
        exit 1
    fi
    echo "Installing python-nose..."
    if [ "$(which pip3)" == "" ]; then
        sudo apt install -y python3-pip
    fi
    sudo pip3 install nose
else
    echo "[ok] python-nose check pass: $nose_version"
fi

#----------------------------------------------------------------------------
# check SSH server
#----------------------------------------------------------------------------
ssh_running=`ps -e | grep sshd`
if [ "$ssh_running" == "" ]; then
    echo "** No SSH server found"
    if [ $install -ne 1 ]; then
        exit 1
    fi
    echo "Installing ssh server"
    sudo apt-get install -y openssh-server
    sudo service ssh start
else
    echo "[ok] ssh sever check pass"
fi

#----------------------------------------------------------------------------
# check RSA keys
#----------------------------------------------------------------------------
rsa_key="ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQDRZVWATztzOoa9LyDIB8FeN6TyFkOY5/sNv4a0P5VXWyqWsqwc7xQtFI0uVU/wtaFMKRKPU4tCrFm1Q78Zx13LbNUtmmeNK4dgwsCrszirHUW1D13WKxEzt2yzeiQJmudW1LoCF/wF8QjkG5ecbcxPXlMA5rjNJZYcSq+0teDsHa5/x+KMiO79WIJu91VRlEVucmmxyDYtvsjv1l+tmoZokSD9U0gq+rxGHnBgA+s8/ljS0D3OaQbkXU6SLA0cUt9VB2I0f2AOOUS6OPARmJp6qQwHQ1azv2BcKPKPy/Qe9ahmek5yRApg1pqnxU3JlmTlsI83K4Gy25ahfJNvyqCP"
key_file="/root/.ssh/authorized_keys"
if [ ! -e $key_file ]; then
    echo "** No authorized_keys file found in root/.ssh"
    if [ $install -eq 1 ]; then
        echo "Create authorized_keys file with valid rsa key"
        if [ ! -e "/root/.ssh" ]; then
            mkdir -p /root/.ssh 
        fi
        echo $rsa_key > $key_file
        check_pass
    else
        exit 1
    fi
fi
key_found=0
# must use process substitution, else cannot modify global variables
while read -r line; do
    if [ "$(echo $line | tr -d '\n')" == "$rsa_key" ]; then
        key_found=1
    fi
done < <(cat $key_file)

if [ $key_found -eq 1 ]; then
    echo "[ok] ssh rsa key check pass"
else
    echo "** No valid rsa key found, will add one"
    echo $rsa_key >> $key_file
fi

check_pass
