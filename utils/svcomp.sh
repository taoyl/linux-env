#!/bin/bash

# taoyl, created at Tue Dec 20 13:09:33 CST 2016

# TODO: use arguments to set them.
# Global settings, default for NanoAP
CORE="cortexa53"
ARCH="armv8"
SUBARCH="SUBARCH=aarch64"

# usage
function usage () {
    echo "Usage: ${0##*/} --focus=BLOCK [-r|--recompile] [-t|--tag TAG] [-h|--help] [-p|--projct]" | lolcat
    exit 1
}

ARGS=`getopt -u -o "t:p:rhv" -l "focus:,project:,tag:,recompile,help,verbose" -- "$@"`
# check if getopt return value
[ $? -ne 0 ] && usage
# reorder arguments
set -- ${ARGS}

#default settings
recompile=0
verbose=0

while [ true ]; do 
    case $1 in 
        --focus)
            block_name="$2"; shift;;
        -t|--tag)
            tag_name="$2"; shift;;
        -p|--project)
            project_name="$2"; shift;;
        -r|--recompile)
            recompile=1;;
        -h|--help)
            usage; break;;
        -v|--verbose)
            verbose=1; break;;
        --)
            shift; break;;
        *)
            echo "**Usage error!"
            usage;;
    esac
    shift
done

# sanity checks
if [ ! -n "$block_name" ]; then
    echo "** No block specified"
    usage
fi
block_path="./focus/$block_name"
if [ ! -d "$block_path" ]; then
    echo "** No block name '$block_name' found in focus"
    exit 1
fi

# change core and arch for different projects
if [ "$project_name" == "zao" ]; then
    CORE="cortexr5"
    ARCH="armv7"
    SUBARCH=""
fi


# compile 
work_dir=$PWD
cd $block_path
if [ $recompile == 1 ]; then
    echo "Cleaning old compile..."
    make clean -f makefile ARCH=$ARCH CORE=$CORE $SUBARCH
fi

echo "Compiling $block_name in focus..."
echo "Compile command: make -j5 -f makefile ARCH=$ARCH CORE=$CORE $SUBARCH V=$verbose 2>&1 | tee $work_dir/comp.log"
make -j5 -f makefile ARCH=$ARCH CORE=$CORE $SUBARCH V=$verbose 2>&1 | tee $work_dir/comp.log

# different blocks use different bin folders, get the path of bin file.
declare -A bin_path_map=([bootloader]="release-$SUBARCH" [other]="bin-$CORE")
if [ -n "${bin_path_map[$block_name]}" ]; then
    bin_path=${bin_path_map[$block_name]}
else
    bin_path=${bin_path_map[other]}
fi

# check if there are target files generated
if [ -n "`grep '\<error\>' $work_dir/comp.log`" ]; then
    echo "** Compile failed!"
    exit 1
fi

echo "Compile done!"
# copy image to share folder
svshare_path="/mnt/sf_SvShare"
if [ ! -d "$svshare_path" ]; then
    mount_sf.sh
fi
if [ ! -d "$svshare_path/image/$block_name" ]; then
    mkdir -p $svshare_path/image/$block_name
fi

# get the bin file name
bin_file_prefix=""
if [ "$project_name" == "zao" ]; then
    bin_file_prefix="cpu0"
fi

bin_file=`ls $bin_path/*$bin_file_prefix*.bin | cut -d'/' -f2`
if [ -n "$tag_name" ]; then
    new_bin_file=${bin_file/\./-${tag_name}.}
fi

echo "Copying images to SvShare folder $svshare_path/image/$block_name/$new_bin_file"
cp $bin_path/$bin_file $svshare_path/image/$block_name/$new_bin_file
ls $svshare_path/image/$block_name | lolcat -as 40

