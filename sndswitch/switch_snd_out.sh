##script to fix sound loose after suspend wake up
## Dell Vostro 3560
CURRPATH=$(pwd)
##CURRPATH=/home/tort/drivers/sndswitch
COUNTER_FILE=$CURRPATH/sndswitch.counter.file
echo COUNTER_FILE : $COUNTER_FILE

INDEX=$(cat $COUNTER_FILE) 


if [ -n "$INDEX" ]; then
    INDEX=$(($INDEX+1))    
else
    INDEX=1    
fi

echo current index is : $INDEX
echo $INDEX > $COUNTER_FILE


echo 'Switching audio to default speakers'
pactl set-card-profile 'alsa_card.pci-0000_00_1b.0' 'output:analog-stereo+input:analog-stereo'



##to know possible options : 
##
##pactl list
##
##pactl set-sink-port 'alsa_output.pci-0000_00_1b.0.analog-stereo' 'analog-output-speaker'
##pactl set-sink-port 'alsa_output.pci-0000_00_1b.0.analog-stereo' 'analog-output-headphones'
##
##
##
##aplay -L
##aplay -l
##
##
##
##pactl set-card-profile 'alsa_card.pci-0000_00_1b.0' 'input:analog-stereo'
##
##pactl set-card-profile 'alsa_card.pci-0000_00_1b.0' 'output:analog-stereo+input:analog-stereo'
##

##eof here
