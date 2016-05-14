#!/bin/bash
set -e
set -x

INDIGO=/opt/ros/indigo
SRC=/src/ros
LIDARSRC=$SRC/lidarserver
cd $INDIGO && source setup.sh

if [ "$1" == "buildrun" ]; then
	
	echo "building.." >> /dev/stdout 
	cd $LIDARSRC && make
	if [ ! -f $LIDARSRC/build/lidarserver ]; then
		echo "build failed..." 2>&1
		exit 1
	fi	
	exec roscore &
	sleep 8
	exec $LIDARSRC/build/lidarserver
elif [ "$1" == "run" ]; then
	if [ ! -f $LIDARSRC/build/lidarserver ]; then
		echo "no executable present..." 2>&1
		exit 1
	fi
	exec $SRC/build/lidarserver
fi
exec bash

#exec "$@"