#! /bin/bash

(
    # stuff in () ensures 1 only instance of script executes. No idea how this works. Source:
    # https://unix.stackexchange.com/questions/492324/how-does-this-script-ensure-that-only-one-instance-of-itself-is-running
    if ! flock -n -x 0
    then
        exit 0
    fi
    # Minimum available memory limit, MB
    THRESHOLD=90

    # Check time interval, sec
    INTERVAL=30
    while :
    do

        free=$(free -m|awk '/^Mem:/{print $4}')
        buffers=$(free -m|awk '/^Mem:/{print $6}')
        cached=$(free -m|awk '/^Mem:/{print $6}')
        available=$(free -m | awk '/^Mem:/{print $7}')

        message="Free $free""MB"", buffers $buffers""MB"", cached $cached""MB"", available $available""MB"""

        if [ $available -lt $THRESHOLD ]
            then
            notify-send "Memory is running out!" "$message"
        fi

        # echo $message

        sleep $INTERVAL

    done
) < $0

