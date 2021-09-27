# Raymond Kiu Raymond.Kiu@quadram.ac.uk
usage () {
  echo ""
  echo "This program replaces strings in any file"
  echo ""
  echo "Usage: $0 [options] -r oldlist newlist file > NEWFILENAME"
  echo "Options:"
  echo " -r replace strings and exit"
  echo " -h print usage and exit"
  echo " -a print author and exit"
  echo " -v print version and exit"
}
version () { echo "version 0.1";}
author () { echo "Author: Raymond Kiu Raymond.Kiu@quadram.ac.uk";}

listA=$2
listB=$3
FILE=$4


replace () {

if [ -e "$listA" ];then
:
else
    echo "$listA file does not seem to exist. Program will now exit."
    exit 1
fi

if [ -e "$listB" ];then
:
else
    echo "$listB file does not seem to exist. Program will now exit."
    exit 1
fi
if [ -e "$FILE" ];then
:
else
    echo "$FILE file does not seem to exist. Program will now exit."
    exit 1
fi

paste -d : $listA $listB | sed 's/\([^:]*\):\([^:]*\)/s%\1%\2%/' > $FILE-sed.script;
sed -f $FILE-sed.script $FILE

rm $FILE-sed.script
exit 0
}

# Call options
while getopts ':rhav' opt;do
  case $opt in
    r) replace; exit;;
    h) usage; exit;;
    a) author; exit;;
    v) version; exit;;
    \?) echo "Invalid option: -$OPTARG" >&2; exit 1;;
    :) echo "Missing option argument for -$OPTARG" >&2; exit 1;;
    *) echo "Unimplemented option: -$OPTARG" >&2; exit 1;;
   esac
done

# Skip over processed options
shift "$((OPTIND-1))"
# check for mandatory positional parameters, only 1 positional argument will be checked
if [ $# -lt 3 ]; then
   echo "Missing optional argument or positional argument"
   echo ""
   echo "Options: ./sequence-stats -h"
   echo ""
   echo ""
   exit 1
fi
