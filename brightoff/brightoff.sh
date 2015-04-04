#!/bin/bash
#script to switch laptop screen
## Dell Vostro 3560
## key: win+f1
CURRPATH=$(pwd)
#CURRPATH=/home/tort/drivers/brightoff
COUNTER_FILE=$CURRPATH/brightoff.counter.file
echo COUNTER_FILE : $COUNTER_FILE

INDEX=$(cat $COUNTER_FILE) 


if [ -n "$INDEX" ]; then
    INDEX=$(($INDEX+1))    
else
    INDEX=1    
fi

echo current index is : $INDEX
echo $INDEX > $COUNTER_FILE

IS_MAKE_OFF=true


STATUS_MONITOR=$(xset q | grep "Monitor is" | awk '{print $3}')

if [ "$STATUS_MONITOR" == "On" ]; then
	echo "Status = [$STATUS_MONITOR]"
	IS_MAKE_OFF=true
else
	echo "Status = [$STATUS_MONITOR]"
	IS_MAKE_OFF=false
fi
echo "IS_MAKE_OFF: [$IS_MAKE_OFF]"

if [ "$IS_MAKE_OFF" = true ] ; then
    echo 'turning off the laptop screen'
    sleep 1 && xset dpms force off
else
    echo 'turning on the laptop screen'
    xset dpms force on
fi

##eof here
