#!/bin/bash
echo "TIMESTAMP,HINET_RESP, HINET_IP, HINET_PKG, NS1_RESP, NS1_IP, NS1_PKG, NS2_RESP, NS2_IP, NS2_PKG"
while true
do
HINET=`dig +nocmd +noall +stats www.wetalk.tw | sed -e 's/;; Query time: //g' -e 's/ msec//g' -e 's/;; SERVER://g' -e 's/;; WHEN: .*//g' -e 's/;; MSG SIZE  rcvd: //g'`
WETALKNS1=`dig +nocmd +noall +stats www.wetalk.tw @ns1.wetalk.tw | sed -e 's/;; Query time: //g' -e 's/ msec//g' -e 's/;; SERVER: //g' -e 's/;; WHEN: .*//g' -e 's/;; MSG SIZE  rcvd: //g'`
WETALKNS2=`dig +nocmd +noall +stats www.wetalk.tw @ns2.wetalk.tw | sed -e 's/;; Query time: //g' -e 's/ msec//g' -e 's/;; SERVER: //g' -e 's/;; WHEN: .*//g' -e 's/;; MSG SIZE  rcvd: //g'`

HIALL=`date +%s`
if [ -z "$HINET" ]; then
    	HIALL+=' , , ,'
    	`dig +trace www.wetalk.tw >> trace`
else 
	for VALUE in $HINET
		do
   		HIALL+=','
   		HIALL+=$VALUE
	done
fi

if [ -z "$WETALKNS1" ]; then
        HIALL+=' , , ,'
        `dig +trace www.wetalk.tw  >> trace`        
else
	for VALUE in $WETALKNS1
	do
	HIALL+=','
   	HIALL+=$VALUE
	done
fi

if [ -z "$WETALKNS2" ]; then
        HIALL+=' , , ,'
        `dig +trace www.wetalk.tw  >> trace`        
else
	for VALUE in $WETALKNS2
	do
	HIALL+=','
	HIALL+=$VALUE
	done
fi

echo $HIALL
sleep 30 
done
