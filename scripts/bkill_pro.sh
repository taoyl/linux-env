#!/bin/bash
##****************************************************************************
## File Name     :  bkill_pro.sh
## Author        :  yuliang.tao (yuliang.tao@bitmain.com)
## Created At    :  Tue 08 Jan 2019 10:12:02 PM CST
## Last Modified :  Thu 10 Jan 2019 01:41:36 PM CST
##
##****************************************************************************
## Description   : Util for kill jobs.
##                 Usage: bkill_pro.sh [-a] [-bt|-at TIME]
##                   -a: kill all jobs
##                   -bt TIME: kill all jobs whose SUBMIT_TIME is before TIME
##                   -at TIME: kill all jobs whose SUBMIT_TIME is after TIME
##
##****************************************************************************
## Change History:  R0.1 2019-01-08 | Initial creation.
##
##****************************************************************************

# bjobs output format
# JOBID   USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
# 1136448 yuliang RUN   normal     etx-end2    cm090       *81952.log Jan  8 18:19

if [ "$1" == "-a" ]; then
    all_jobs=$(bjobs | /bin/grep '^[0-9]\+')
    all_job_ids=$(bjobs | /bin/grep '^[0-9]\+' | awk '{print $1}')
    echo "$all_jobs"
    read -p "Killing all jobs (Y/N)? " ans
    if [ "$ans" == "Y" ]; then
        echo $all_job_ids
        bkill $all_job_ids
    fi
    exit 0
fi

if [[ "$1" == "-bt" || "$1" == "-at" ]]; then
    # $2 format is same as the output of bjobs
    till_time=$(echo $2 | awk '{print $2 " " $3}' | sed 's/:/ /')
    echo "till_time: $till_time"
    to_be_killed_job_ids=""

    # must use this style to change the global varible in while
    # https://stackoverflow.com/questions/13726764/while-loop-subshell-dilemma-in-bash
    while read -r job; do
        stat=$(echo $job | awk '{print $3}')
        job_time=$(echo $job | awk '{print $9 " " $10}' | sed 's/:/ /')
        # For PEND job, no EXEC_HOST field
        if [ "$stat" == "PEND" ]; then
            job_time=$(echo $job | awk '{print $8 " " $9}' | sed 's/:/ /')
        fi

        less_than=$(echo "$till_time $job_time" | \
            awk '{x=int(sprintf("%d%02d%02d",$1,$2,$3));y=int(sprintf("%d%02d%02d",$4,$5,$6)); if(y<x)print "1"; else print "0"}')
        if [[ "$less_than" == "1" && "$1" == "-bt" || \
             "$less_than" == "0" && "$1" == "-at" ]]; then
            curr_jid=$(echo $job | awk '{print $1}')
            to_be_killed_job_ids="$to_be_killed_job_ids $curr_jid"
            echo "$job"
        fi
    done < <(bjobs | /bin/grep '^[0-9]\+')
            
    echo
    if [ "$to_be_killed_job_ids" != "" ]; then
        echo "$to_be_killed_job_ids"
        read -p "Killing all these jobs (Y/N)? " ans
        if [ "$ans" == "Y" ]; then
            echo "$ans"
            bkill $to_be_killed_job_ids
        fi
    fi
    exit 0
fi
