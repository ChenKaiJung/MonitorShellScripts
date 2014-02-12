#!/bin/bash
INTERVAL=30
echo "TimeStamp,Proto,Recv-Q,Send-Q,Local,Local-Port,Foreign,Foreign-Port,State"

while true
do
	LIST=`netstat -nat | awk '{ print $1 "," $2 "," $3 "," $4 "," $5 "," $6 }' |  tr ':' ','`  
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
		STATE=`echo $ITEM | cut -d "," -f8`
                if [ "$STATE" = "LISTEN" ] ; then
                	OUTPUT=""
                        continue
                fi 			
        	printf '%s\n' "$OUTPUT"
        	OUTPUT=""
	done
	sleep $INTERVAL
done