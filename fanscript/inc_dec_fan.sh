##script to increase\decrease fan speed sequentual pressing of same button.
## logic is : 0...1...2...0...1...2...0..etc
## Dell Vostro 3560

function calcuateCurrentFanLevel()
{
    local OUTPUT="$(i8kfan)"
    local PARAMS=( $OUTPUT )
    if [ ${PARAMS[0]} -eq -1 ]
    then 
    ##echo "param 0 is -1"
      echo ${PARAMS[1]}
    else
      echo ${PARAMS[0]}
    fi
}

function toNextFanLevel()
{
    local CURRENT_LEVEL=$1
    local NEXT_LEVEL=$(($CURRENT_LEVEL+1))
    NEXT_LEVEL=$(($NEXT_LEVEL%3))   
    echo $NEXT_LEVEL
}

function setFanLevel(){
    local PARAM_LEVEL=$1;
    local RESULT="$(i8kfan $PARAM_LEVEL $PARAM_LEVEL)"
    echo $RESULT
}

CURR_LEVEL=$(calcuateCurrentFanLevel)
NEXT_LEVEL=$(toNextFanLevel $CURR_LEVEL)
setFanLevel $NEXT_LEVEL


## to know the temperature use 
## i8kctl temp
## or 
## i8fan
##eof here
