#!/bin/bash
#know monitors you have
#xrandr -q
##script to increase\decrease brightness & gamma
## usage:
#./brightsmooth.sh
#./brightsmooth.sh -decrease
#./brightsmooth.sh -default
##todo : split me to methods

CURRPATH=$(pwd)


COUNTER_FILE=$CURRPATH/ctrstsmooth.counter.file
echo COUNTER_FILE : $COUNTER_FILE

INDEX=$(cat $COUNTER_FILE) 


if [ -n "$INDEX" ]; then
    INDEX=$(($INDEX+1))    
else
    INDEX=1    
fi

echo current index is : $INDEX
echo $INDEX > $COUNTER_FILE


LEVEL_FILE=$CURRPATH/ctrstsmooth.level.file
echo LEVEL_FILE : $LEVEL_FILE

LATEST_LEVEL=$(cat $LEVEL_FILE)

if [ -n "$LATEST_LEVEL" ]; then
    #do nothing here
    echo ""   
else    
    LATEST_LEVEL=$(xrandr --verbose | grep -i brightness  |grep -o '[0-9].*') 
fi


echo current LATEST_LEVEL is : $LATEST_LEVEL

STEP=10
echo STEP : $STEP

if [ $(( $INDEX % 50 )) -eq 0 ] ; then
   echo "setting default value as 50 presses detected"
   LATEST_LEVEL=1.0
   STEP=0
fi

if [[ $1 = "-default" ]]; then
	echo "setting default value as -default flag detected"
	LATEST_LEVEL=1.0
	STEP=0
fi

echo current LATEST_LEVEL is : $LATEST_LEVEL

CURRENT_FLOAT=$LATEST_LEVEL
echo CURRENT_FLOAT : $CURRENT_FLOAT

CURRENT_PERCENT=$(echo "scale=4; $CURRENT_FLOAT*100" | bc)
echo CURRENT_PERCENT : $CURRENT_PERCENT



IS_INCREASE=true

if [[ $1 = "-decrease" ]]; then
	echo "setting IS_INCREASE to false"
	IS_INCREASE=false
fi

TARGET_PERCENT=""

if [ "$IS_INCREASE" = true ] ; then
    echo 'Increasing brightness'
    TARGET_PERCENT=$(echo "scale=4; $CURRENT_PERCENT+$STEP" | bc)    
else
    echo 'Decreasing brightness'
    TARGET_PERCENT=$(echo "scale=4; $CURRENT_PERCENT-$STEP" | bc)  
fi
echo TARGET_PERCENT : $TARGET_PERCENT

if [ $(( ${TARGET_PERCENT%.*}  )) -eq 0 ] ; then
   echo "zero target percent detected, skipping"
   exit 0
fi

TARGET_FLOAT=$(echo "scale=4; $TARGET_PERCENT/100" | bc)
echo TARGET_FLOAT : $TARGET_FLOAT

xrandr --output LVDS1 --brightness $TARGET_FLOAT
###xrandr --output VGA1 --brightness $TARGET_FLOAT
echo $TARGET_FLOAT > $LEVEL_FILE
