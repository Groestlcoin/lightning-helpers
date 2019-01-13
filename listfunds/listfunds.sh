#!/bin/bash

if [[ $1 == G ]]; then
    #echo "Used unit is GRS"
    DIV=100000000
    UNIT=GRS
elif  [[ $1 == m ]]; then
    #echo "Used unit is mGRS"
    DIV=100000
    UNIT=mGRS
elif [[ $1 == y ]]; then
    #echo "Used unit is microGRS"
    DIV=100
    UNIT=yGRS
elif [[ $1 == g ]]; then
    #echo "Used unit is groestls"
    DIV=100
    UNIT=groestls
else
    #echo "Used unit is gro"
    DIV=1
    UNIT=gro
fi

lightning-cli listfunds | grep "value" | sed 's/      "value": //g' | sed 's/,//g' | awk -v div="$DIV" -v u="$UNIT" '{s+=$1} END {print  s/div " " u " available to fund channels"}'
FREE=$(lightning-cli listfunds | grep "value" | sed 's/      "value": //g' | sed 's/,//g' | awk -v div="$DIV" '{s+=$1} END {print  s/div}')

lightning-cli listfunds | grep "channel_sat" | sed 's/      "channel_sat": //g' | sed 's/,//g' | awk -v div="$DIV" -v u="$UNIT" '{s+=$1} END {print s/div " " u " owned in channels"}'
CHAN=$(lightning-cli listfunds | grep "channel_sat" | sed 's/      "channel_sat": //g' | sed 's/,//g' | awk -v div="$DIV" '{s+=$1} END {print s/div}')

lightning-cli listfunds | grep "channel_total_sat" | sed 's/      "channel_total_sat": //g' | sed 's/,//g' | awk -v div="$DIV" -v u="$UNIT" '{s+=$1} END {print s/div " " u " total channel capacity"}'
CAP=$(lightning-cli listfunds | grep "channel_total_sat" | sed 's/      "channel_total_sat": //g' | sed 's/,//g' | awk '{s+=$1} END {print s}')

echo "---------------"
SUM=$(awk -v f="$FREE" -v c="$CHAN" 'BEGIN {print f+c}')
echo "Total funds: $SUM $UNIT"
if [[ $CAP -gt 0 ]]; then
	CHAN=$(lightning-cli listfunds | grep "channel_sat" | sed 's/      "channel_sat": //g' | sed 's/,//g' | awk '{s+=$1} END {print s}')
	PER=$(awk -v n="$CHAN" -v d="$CAP" 'BEGIN {print n*100/d}')
	echo "Percentage of total channel capacity owned: $PER"
fi
echo "---------------"
echo "Add command line parameter [G] for GRS, [m] for mGRS, [y] for microGRS, [b] for groestls and nothting or anything else for gro"
