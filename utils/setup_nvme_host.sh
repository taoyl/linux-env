#!/bin/bash

# Host setup for NVMe test
# taoyl, created at Fri Dec  1 14:54:46 CST 2017

# Global settings, default for NanoAP


#----------------------------------------------------------------------------
# Function definition
#----------------------------------------------------------------------------
# usage
function usage () {
    echo "Usage: ${0##*/} [-r|--install] [-h|--help]"
    exit 1
}

function fix_or_exit () {
    if [ $install -ne 1 ]; then 
        exit 1
    fi
}

function check_pass () {
    echo
    echo "[ok] all checks pass"
    echo
    exit 0
}

function install_tests () {
    cp -r nvme_tests/py_tests /root/nvme
    rm -rf nvme_tests
    echo "[ok] nvme tests installed"
}

function clone_nvmecli () {
    if [ "$(which git)" == "" ]; then
        sudo apt-get install -y git
    fi
    git clone https://github.com/taoyl/nvme_tests.git 
    echo
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
# check nvme-cli
#----------------------------------------------------------------------------
if [ "$(which nvme)" == "" ]; then
    echo "** No nvme-cli found"
    fix_or_exit
    clone_nvmecli
    if [ -e "nvme_tests/nvme" ]; then
        cp nvme_tests/nvme /usr/local/bin/
        echo "[ok] nvme-cli installed"
    else
        echo "** Fail to install nvme-cli"
        exit 1
    fi
else
    echo "[ok] nvme-cli check pass"
fi

#----------------------------------------------------------------------------
# check host tests
#----------------------------------------------------------------------------
if [ -e "/root/nvme/run_nvme_test.py" ]; then
    echo "[ok] nvme tests check pass"
else
    echo "** No nvme tests found"
    fix_or_exit
    if [ -e "nvme_tests/py_tests" ]; then
        install_tests
    else
        clone_nvmecli
        if [ -e "nvme_tests/py_tests" ]; then
            install_tests
        else
            echo "** Fail to install nvme tests"
            exit 1
        fi
    fi
fi

#----------------------------------------------------------------------------
# data file check
#----------------------------------------------------------------------------
mp4_files=(small.mp4 medium.mp4 large.mp4)
data_file_exist=1
for df in ${mp4_files[@]}; do
    if [ ! -e "/root/nvme/data/$df" ]; then
        echo "** Data file $df not found in /root/nvme/data"
        data_file_exist=0
    fi
done
if [ $data_file_exist -eq 0 ]; then
    echo "Please copy data files to /root/nvme/data"
    exit 1
else
    echo "[ok] data files check pass"
fi

#----------------------------------------------------------------------------
# check python version
#----------------------------------------------------------------------------
py_version=`python3 -V`
py_ver_m=`python3 -V | cut -d' ' -f2 | cut -d'.' -f1`
if [ "$py_ver_m" != "3" ]; then
    echo "*** No python3 found"
    fix_or_exit
    sudo apt-get install -y python3
    sudo apt-get install -y python3-pip
    echo
    echo "[ok] python3 installed"
else
    echo "[ok] python version check pass: $py_version"
fi

#----------------------------------------------------------------------------
# check nose
#----------------------------------------------------------------------------
#nose_version=`pip3 list | grep '\<nose\>' | sed 's/[()]//g'`
#if [ "$nose_version" == "" ]; then
nose_installed=`python3 -c "import nose" 2>&1 | grep 'ImportError\|ModuleNotFoundError'`
if [ "$nose_installed" != "" ]; then
    echo "** No python-nose found"
    fix_or_exit
    if [ "$(which pip3)" == "" ]; then
        sudo apt install -y python3-pip
    fi
    sudo pip3 install nose
    echo
    echo "[ok] python-nose installed"
else
    echo "[ok] python-nose check pass"
fi


#----------------------------------------------------------------------------
# check SSH server
#----------------------------------------------------------------------------
ssh_running=`ps -e | grep sshd`
if [ "$ssh_running" == "" ]; then
    echo "** No SSH server found"
    fix_or_exit
    sudo apt-get install -y openssh-server
    sudo service ssh start
    echo
    echo "[ok] ssh server installed"
else
    echo "[ok] ssh sever check pass"
fi

#----------------------------------------------------------------------------
# check RSA keys
#----------------------------------------------------------------------------
rsa_key="AAAAB3NzaC1yc2EAAAABJQAAAQEA4m8n7VsLrGRvG/jUY06S4qvQA+HHMOPVpk5InKtt5CfCl65MZPxoKowqcQSg8psmy5+No+WYaduDNC8dot5SPIzFw4D3xa00/rg0OwkGPNlU+zQF2NmQjDEtf35gf3LtcHZlZ1pqmNQit/sVEZy24hpKNXGqes83/vi72fiXG+oLnHtEgZOBEoULQexfJwh3UFI6nXHCmB9BfKlGxlO8zkFfGIIcw/Yfbk96EWypnlmSRwjhq1Sv1jemq8xIfTK66SNuZ/MG/btd/ciu9MQPEs81E7gLqKRLBkWJ9gDv34hhYhUs99M3dNWgpaSCTESN9LQNz+TvkEly9WiWy2aTMw=="
key_file="/root/.ssh/authorized_keys"
if [ ! -e $key_file ]; then
    echo "** No authorized_keys file found in root/.ssh"
    fix_or_exit
    if [ ! -e "/root/.ssh" ]; then
        mkdir -p /root/.ssh 
    fi
    echo "ssh-rsa $rsa_key" > $key_file
    echo "[ok] create authorized_keys file with valid rsa key"
    check_pass
fi
# authorized_keys file exists, check if valid rsa key exists
key_found=0
# must use process substitution, else cannot modify global variables
while read -r line; do
    if [ "$(echo $line | tr -d '\n' | cut -d' ' -f2)" == "$rsa_key" ]; then
        key_found=1
        break
    fi
done < <(cat $key_file)

if [ $key_found -eq 1 ]; then
    echo "[ok] ssh rsa key check pass"
else
    echo "** No valid rsa key found"
    fix_or_exit
    echo "ssh-rsa $rsa_key" >> $key_file
    echo "[ok] add a valid rsa key"
fi

check_pass
