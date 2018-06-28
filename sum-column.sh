#!/bin/bash
if [ $# -lt 1 ] ; then
    echo ""
    echo "usage: sum-column.sh FILE.txt"
    echo "sum up the numbers in one column"
    echo ""
    exit 0
fi

filear=${@};
for i in ${filear[@]}

do awk '{ sum += $1 } END { print sum }' $i;
done
