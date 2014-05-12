##script to increase\decrease fan speed 
## Dell Vostro 3560
CURRPATH=$(pwd)
#CURRPATH=/home/tort/drivers/fanscript
COUNTER_FILE=$CURRPATH/fanscript.counter.file
echo COUNTER_FILE : $COUNTER_FILE

INDEX=$(cat $COUNTER_FILE) 


if [ -n "$INDEX" ]; then
    INDEX=$(($INDEX+1))    
else
    INDEX=1    
fi

echo current index is : $INDEX
echo $INDEX > $COUNTER_FILE

IS_MAKE_FASTER=true

if [ $(($INDEX%2)) -eq 0 ]; then
    echo "even"
    IS_MAKE_FASTER=true
else
    echo "odd"
    IS_MAKE_FASTER=false
fi

i8kctl fan

if [ "$IS_MAKE_FASTER" = true ] ; then
    echo 'Increasing cooler'
    i8kctl fan 2 2
else
    echo 'Decreasing cooler'
    i8kctl fan 1 1
fi


## to know the temperature use 
## i8kctl temp
##eof here
