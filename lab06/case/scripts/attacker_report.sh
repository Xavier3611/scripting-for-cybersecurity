#!/bin/bash

if [ $# -ne 1 ]; then
    echo "Usage: $0 <logfile>" >&2
    exit 1
fi

LOGFILE=$1

if [ ! -f "$LOGFILE" ]; then
    echo "Error: file '$LOGFILE' not found" >&2
    exit 2
fi

FAILED=$(grep -c "Failed password" "$LOGFILE")
TOP_IP=$(grep "Failed password" "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if($i=="from") print $(i+1)}' | sort | uniq -c | sort -nr | head -n 1 | awk '{print $2}')
TOP_3_IPS=$(grep "Failed password" "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if($i=="from") print $(i+1)}' | sort | uniq -c | sort -nr | head -n 3)
TOP_3_USERS=$(grep "Failed password" "$LOGFILE" | awk '{for(i=1;i<=NF;i++) if($i=="for") print $(i+1)}' | sort | uniq -c | sort -nr | head -n 3)

echo "Total Failed Logins : $FAILED"
echo "Top Attacker IP     : ${TOP_IP:-None}"
echo "Top 3 Attackers     :"
echo "$TOP_3_IPS"
echo "Top 3 Users Targeted:"
echo "$TOP_3_USERS"

exit 0