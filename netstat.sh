#!/bin/bash
INTERVAL=30
echo "TimeStamp,Proto,Recv-Q,Send-Q,Address,Port,State"

while true
do
	LIST=`netstat -nat | awk '{ print $1 "," $2 "," $3 "," $5 "," $6}' |  tr ':' ','`  
	TIMESTAMP=`date +%s`
	for ITEM in $LIST
	do
		OUTPUT+=$TIMESTAMP
		OUTPUT+=","
		OUTPUT+=$ITEM
		PROTO=`echo $ITEM | cut -d "," -f1`
		if [ "$PROTO" = "Active" ] || [ "$PROTO" = "Proto" ] ; then
			OUTPUT=""
			continue
		fi
		STATE=`echo $ITEM | cut -d "," -f6`
                if [ "$STATE" = "LISTEN" ] ; then
                	OUTPUT=""
                        continue
                fi 			
        	printf '%s\n' "$OUTPUT"
        	OUTPUT=""
	done
	sleep $INTERVAL
done