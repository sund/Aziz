#!/bin/bash

################################
#
# Aziz-light.sh
# -----------------------------
# BottleRocket
# controls X10 devices
# Aziz, Light!
#
################################

################################
# includes

################################
# variables
VER="Aziz, LIGHT! version .4b"
housecode="M" 
#livingcode="3"
#tablecode="4"
officecode="2"
fancode="1"
bedcode="3"
allList="1 2 3"
maxDev=4
slaap=`sleep 2`
serialPort="/dev/ttyUSB0"
logPath="/tmp/logAziz.log"

################################
# functions
whichBR() {
	local mypath=`command -v br`
	if [ -x $mypath ]
	then
	    {
	    brpath="$mypath"
	    }
	else
	    {
	    echo "br not found -- exiting"
	    echo "is br installed and in the PATH?"
	    exit 1
	    }
	fi
}

all_on() {
	for cnt in $allList
	do
	$brpath -x $serialPort M$cnt ON
#	sayON $cnt
	done 
	echo "Performed ALLON on all $housecode at `date`" >> $logPath
}

all_off() {
	for cnt in $allList
	do
	$brpath -x $serialPort M$cnt OFF
#	sayOFF $cnt
	done 
	echo "Performed ALLOFF on all $housecode at `date`" >> $logPath
}

#bedroom on/off
bedroom_off() {
        $brpath -x $serialPort -c$housecode -f$bedcode
	echo "Performed BEDOFF on $housecode:$bedcode at `date`" >> $logPath
}

bedroom_on() {
        $brpath -x $serialPort -c$housecode -n$bedcode
	echo "Performed BEDON on $housecode:$bedcode at `date`" >> $logPath
}

#office on/off
office_off() {
        `$brpath -x $serialPort -c$housecode -f$officecode`
	echo "Performed OFFOFF on $housecode:$officecode at `date`" >> $logPath
}

office_on() {
        $brpath -x $serialPort -c$housecode -n$officecode
        #echo $brpath -x $serialPort -c$housecode -n$officecode
	echo "Performed OFFON on $housecode:$officecode at `date`" >> $logPath
}

#fan on/off
fan_off() {
    $brPATH -x $serialPort -c$housecode -f$fancode
	echo "Performed FANOFF on $housecode:$fancode at `date`" >> $logPath
}

fan_on() {
    $brPATH -x $serialPort -c$housecode -n$fancode
	echo "Performed FANON on $housecode:$fancode at `date`" >> $logPath
}

beepo() {
	beep
}
###############################
# actual code
whichBR
echo #

case "$1" in
"all on" | "allon")
	all_on
	beepo
	exit 0
;;

"all off" | "alloff")
	all_off
	beepo
	exit 0
;;

"bed off" | "bedoff")
	bedroom_off
	beepo
	exit 0
;;

"bed on" | "bedon")
	bedroom_on
	beepo
	exit 0
;;

"office off" | "offoff")
	office_off
	beepo
	exit 0
;;

"office on" | "offon")
	office_on
	beepo
	exit 0
;;

"fan on" | "fanon")
	fan_on
	beepo
	exit 0
;;

"fan off" | "fanoff")
	fan_off
	beepo
	exit 0
;;
*)
## usage
	echo $VER
	echo "USAGE:"
	echo "	allon - turns on all lights in house"
	echo "	alloff - turns off all lights in house"
	echo "	bed | office 	on | off"
	echo "	[bed|office][on|off]"
	exit 1 
;;
esac

# exit OK
exit 0
