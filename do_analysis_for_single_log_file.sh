#! /bin/bash
fileName=$1
echo "----------------------------------------------"

echo "Total query count"
cat $fileName | wc -l

echo "Count & http_status"
cat $fileName | awk '{print $9}' | sort | uniq -c

echo "Max response time"
cat $fileName | awk '{print $(NF-2)}' | sort -n | tail -1

echo "Average response time"
echo "Response time: 90 percentile"
cat $fileName | awk '{print $(NF-2)}'| sort -n|awk 'BEGIN{i=0} {s[i]=$1; i++;} END{print s[int(NR*0.90-0.5)]}'

echo "Response time: 95 percentile"
cat $fileName | awk '{print $(NF-2)}'| sort -n|awk 'BEGIN{i=0} {s[i]=$1; i++;} END{print s[int(NR*0.95-0.5)]}'

echo "Response time: 99 percentile"
cat $fileName | awk '{print $(NF-2)}'| sort -n|awk 'BEGIN{i=0} {s[i]=$1; i++;} END{print s[int(NR*0.99-0.5)]}'
