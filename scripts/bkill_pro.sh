#!/bin/bash
##****************************************************************************
## File Name     :  bkill_pro.sh
## Author        :  yuliang.tao (yuliang.tao@bitmain.com)
## Created At    :  Tue 08 Jan 2019 10:12:02 PM CST
## Last Modified :  Fri 18 Jan 2019 11:51:05 AM CST
##
##****************************************************************************
## Description   : Util for kill jobs.
##                 Usage: bkill_pro.sh [-a|--all] [-b|--begin_time TIME] [-e|--end_time TIME] [-q|--queue QUEUE] [-h|--help]
##                   -a|--all: kill all jobs.
##                   -q|--queue QUEUE: Kill jobs on a specific queue, either be used with -a, -b, -e option or be used alone.
##                   -b|--begin_time TIME: kill all jobs with SUBMIT_TIME after TIME (included)
##                   -e|--end_time TIME: kill all jobs with SUBMIT_TIME before TIME (included)
##
##****************************************************************************
## Change History:  R0.1 2019-01-08 | Initial creation.
##
##****************************************************************************

# bjobs output format
# JOBID   USER    STAT  QUEUE      FROM_HOST   EXEC_HOST   JOB_NAME   SUBMIT_TIME
# 1136448 yuliang RUN   normal     etx-end2    cm090       *81952.log Jan  8 18:19
declare -A MONTHS
MONTHS=([Jan]=1 [Feb]=2 [Mar]=3 [Apr]=4 [May]=5 [Jun]=6 [Jul]=7 [Aug]=8 [Sep]=9 [Oct]=10 [Nov]=11 [Dec]=12)

#-----------------------------------------------------------------------------
# function definition
#-----------------------------------------------------------------------------
usage() {
    echo "Usage: bkill_pro.sh [-a|--all] [-b|--begin_time TIME] [-e|--end_time TIME] [-q|--queue QUEUE] [-h|--help]"
    echo "    -a|--all: kill all jobs"
    echo "    -q|--queue QUEUE: Kill jobs on a specific queue, either be used with -a, -b, -e option or be used alone"
    echo "    -b|--begin_time TIME: kill all jobs with SUBMIT_TIME after TIME (included)"
    echo "    -e|--end_time TIME: kill all jobs with SUBMIT_TIME before TIME (included)"
    exit 0
}

ask_and_execute() {
    echo
    if [ "$1" != "" ]; then
        echo "$*"
        read -p "Killing all these jobs (Y/N)? " ans
        if [ "$ans" == "Y" ]; then
            echo "$ans"
            bkill $*
        fi
    fi
    exit 0
}

get_submit_time() {
    # time format: Jan 8 18:19 --> 1 8 18 19
    echo "${MONTHS[$(echo $1 | awk '{print $1}')]} $(echo $1 | awk '{print $2" "$3}' | sed 's/:/ /')"
}

#-----------------------------------------------------------------------------
# Parse command-line arguments
#-----------------------------------------------------------------------------
KILL_ALL=0
KILL_BEGIN_TIME=""
KILL_END_TIME=""
QUEUE=""
POSITIONAL=()
while [[ $# -gt 0 ]]; do
    key="$1"
    case $key in
        -a|--all)
            KILL_ALL=1
            shift ;;
        -q|--queue)
            QUEUE="$2"
            shift; shift ;;
        -b|--begin_time)
            KILL_BEGIN_TIME="$2"
            shift; shift ;;
        -e|--end_time)
            KILL_END_TIME="$2"
            shift; shift ;;
        -h|--help)
            usage ;;
        *)
            POSITIONAL+=("$1") # save other positional args
            shift ;;
    esac
done
set -- "${POSITIONAL[@]}"  # restore positional args
if [[ $# -gt 0 ]]; then
    echo "Unknown positional args: ${POSITIONAL[*]}"
    usage
fi


#-----------------------------------------------------------------------------
# Kill all jobs
#-----------------------------------------------------------------------------
if [ "$KILL_ALL" == "1" ]; then
    if [[ "$QUEUE" != "" ]]; then
        all_jobs=$(bjobs | /bin/grep '^[0-9]\+' | /bin/grep $QUEUE)
    else
        all_jobs=$(bjobs | /bin/grep '^[0-9]\+')
    fi
    all_job_ids=$(bjobs | /bin/grep '^[0-9]\+' | awk '{print $1}')
    echo "$all_jobs"
    ask_and_execute $all_job_ids
fi


#-----------------------------------------------------------------------------
# Kill jobs with SUBMIT_TIME within the range of [BEGIN_TIME, END_TIME]
#-----------------------------------------------------------------------------
# KILL_BEGIN_TIME and KILL_END_TIME format: Jan 8 18:19
if [[ "$KILL_BEGIN_TIME" == "" ]]; then
    begin_time=""
else
    begin_time=$(get_submit_time "$KILL_BEGIN_TIME")
fi
if [[ "$KILL_END_TIME" == "" ]]; then
    end_time=""
else
    end_time=$(get_submit_time "$KILL_END_TIME")
fi
echo "begin_time: $begin_time, end_time: $end_time"
    
if [[ "$begin_time" != "" || "$end_time" != "" ]]; then
    to_be_killed_job_ids=""

    # must use this style to change the global varible in while
    # https://stackoverflow.com/questions/13726764/while-loop-subshell-dilemma-in-bash
    while read -r job; do
        stat=$(echo $job | awk '{print $3}')
        qname=$(echo $job | awk '{print $4}')
        # filter queue name. If unmatched, skip current job
        if [[ "$QUEUE" != "" ]]; then
            job_time_str="$(echo $job | /bin/grep $QUEUE | awk '{print $(NF-2)" "$(NF-1)" "$NF}')"
        else
            job_time_str="$(echo $job | awk '{print $(NF-2)" "$(NF-1)" "$NF}')"
        fi
        if [[ "$job_time_str" == "" ]]; then
            continue
        fi
        job_time=$(get_submit_time "$job_time_str")
        # echo "curr job time: $job_time

        # If boundary time is not specified, means no boundary.
        if [[ "$begin_time" == "" ]]; then
            time_ge=1
        else
            time_ge=$(echo "$begin_time $job_time" | \
                awk '{x=int(sprintf("%d%02d%02d%02d",$1,$2,$3,$4));y=int(sprintf("%d%02d%02d%02d",$5,$6,$7,$8)); if(y>=x)print "1"; else print "0"}')
        fi
        if [[ "$end_time" == "" ]]; then
            time_le=1
        else
            time_le=$(echo "$end_time $job_time" | \
                awk '{x=int(sprintf("%d%02d%02d%02d",$1,$2,$3,$4));y=int(sprintf("%d%02d%02d%02d",$5,$6,$7,$8)); if(y<=x)print "1"; else print "0"}')
        fi
        if [[ "$time_ge" == "1" && "$time_le" == "1" ]]; then
            curr_jid=$(echo $job | awk '{print $1}')
            to_be_killed_job_ids="$to_be_killed_job_ids $curr_jid"
            echo "$job"
        fi
    done < <(bjobs | /bin/grep '^[0-9]\+')

    ask_and_execute $to_be_killed_job_ids

fi

#-----------------------------------------------------------------------------
# Kill jobs on a sepecific queue
#-----------------------------------------------------------------------------
if [ "$QUEUE" != "" ]; then
    qname_for_kill=$2
    to_be_killed_job_ids=""

    while read -r job; do
        qname=$(echo $job | awk '{print $4}')

        if [ "$qname" == "$QUEUE" ]; then
            curr_jid=$(echo $job | awk '{print $1}')
            to_be_killed_job_ids="$to_be_killed_job_ids $curr_jid"
            echo "$job"
        fi
    done < <(bjobs | /bin/grep '^[0-9]\+')

    ask_and_execute $to_be_killed_job_ids
fi
