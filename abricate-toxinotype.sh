# This script uses Abricate-0.8.11 with custom database for C. perfringens toxins to assign toxinotypes to C. perfringens genomes.
#!/bin/bash
# Raymond Kiu Raymond.Kiu@quadram.ac.uk

#print the options
usage () {
  echo ""
  echo "This bash script assigns toxinotypes to C. perfringens genome assemblies using ABRicate v0.8.11 (type will be shown on stdout)"
  echo "Dependency: ABRicate v0.8.11 with toxinCP database"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk (2020)"
  echo "";
}
version () { echo "version 1.0";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}


while getopts ':hav' opt;
do
  case $opt in
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;

esac
done

# skip over the processed options
shift $((OPTIND-1))

#check for mandatory positional parameters
if [ $# -lt 1 ]; then
  echo ""
  echo "This bash script assigns toxinotypes to C. perfringens genome assemblies using ABRicate v0.8.11"
  echo "Dependency: ABRicate v0.8.11 with toxinCP database"
  echo ""
  echo "Usage: $0 [options] FASTAFILE"
  echo "Option:"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
  echo ""
  echo "Version 1.0"
  echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk (2020)"
  echo "";
exit 1
fi

abricate --quiet --db toxinCP $1 |awk '{if($9>90 && $10>90)print $5}'|sort -u|grep -E -x 'plc|cpb|etx|iap|ibp|cpe|netB'|awk '{print}' ORS=''> $1-toxins

grep -E -x -c "plc" $1-toxins|awk '{if ($0==1) print "A"}'
grep -E -x -c "cpbetxplc" $1-toxins|awk '{if ($0==1) print "B"}'
grep -E -x -c "cpbplc" $1-toxins|awk '{if ($0==1) print "C"}'
grep -E -x -c "cpbcpeplc" $1-toxins|awk '{if ($0==1) print "C"}'
grep -E -x -c "etxplc" $1-toxins|awk '{if ($0==1) print "D"}'
grep -E -x -c "cpeetxplc" $1-toxins|awk '{if ($0==1) print "D"}'
grep -E -x -c "iapibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeiapibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "iapplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "ibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeiapplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeibpplc" $1-toxins|awk '{if ($0==1) print "E"}'
grep -E -x -c "cpeplc" $1-toxins|awk '{if ($0==1) print "F"}'
grep -E -x -c "netBplc" $1-toxins|awk '{if ($0==1) print "G"}'

rm $1-toxins

exit 1;
