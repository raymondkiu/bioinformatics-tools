# e.g. BA1_R1.fastq BA2_R1.fastq BA3_R1.fastq
# Using this one-liner command will generate:
# $ basename-one-liner.sh _R1.fastq
# BA1,BA2,BA3
for j in *$1 ; do basename $j $1 ;done |sed ':a;N;$!ba;s/\n/,/g'
