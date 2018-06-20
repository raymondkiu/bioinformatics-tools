# informatics-tools
Some small and simple scripts useful for various bioinformatics purposes. 

### extract-contigs.pl
This Perl script is able to extract contigs of FASTA files either by contig name or a list of contig names.
```
$ extract-contigs.pl single CONTIGNAME FASTAFILE
```

### ver-horizontal.sh
This Bash script converts a list to horizontal view on the standard output for various automation purposes.
```
$ ver-horizontal.sh LIST
```
For instance, a file named LIST
```
hello
world
happy
```
will be converted to 
```
hello world happy
```
### assembly-stats.pl
This Perl script gives you general assembly statistics including contig number, genome size, largest contig (bases), GC content, N count and gap count. It takes the inputs of FASTA assemblies.
```
$ assembly-stats.pl FASTAFILE
```
It generates data on standard output as follows:
```
Sampl      Genome  Contigs Mean    Median  N50     Largest GC(%)   N_count N(%)    Gap_count
test.fasta 158     2       79      89      89      89      5.95    26      16.46   4
```
### reverse-complement.sh
This Bash script generates reverse complement for nucleotide FASTA files.
```
$ reverse-complement.sh -o OUTPUT_FILENAME FASTAFILE
```
Option -o can be omitted, the default output filename is FASTAFILE-complement.fasta
