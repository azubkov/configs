##script to switch laptop screen
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

if [ $(($INDEX%2)) -eq 0 ]; then
    echo "even"
    IS_MAKE_OFF=true
else
    echo "odd"
    IS_MAKE_OFF=false
fi

if [ "$IS_MAKE_OFF" = true ] ; then
    echo 'turning off the laptop screen'
    xset dpms force off
else
    echo 'turning on the laptop screen'
    xset dpms force on
fi

##eof here
