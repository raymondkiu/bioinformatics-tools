# This script uses Abricate-0.8.11 with custom database for C. perfringens toxins to assign toxinotypes to C. perfringens genomes.

abricate --quiet --db toxinCP $1 |awk '{if($9>90 && $10>90)print $5}'|sort|grep -E -x 'plc|cpb|etx|iap|ibp|cpe|netB'|awk '{print}' ORS=''> $1-toxins

grep -E -x -c "plc" $1-toxins|awk '{if ($0==1) print "A"}'
grep -E -x -c "cpbetxplc" $1-toxins|awk '{if ($0==1) print "B"}'
grep -E -x -c "cpbplc" $1-toxins|awk '{if ($0==1) print "C"}'
grep -E -x -c "cpbcpeplc" $1-toxins|awk '{if ($0==1) print "C"}'
grep -E -x -c "etxplc" $1-toxins|awk '{if ($0==1) print "D"}'
grep -E -x -c "cpeetxplc" $1-toxins|awk '{if ($0==1) print "D"}'
grep -E -x -c "iapibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeiapibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeplc" $1-toxins|awk '{if ($0==1) print "F"}'
grep -E -x -c "netBplc" $1-toxins|awk '{if ($0==1) print "G"}'

rm $1-toxins
