#!/usr/bin/perl
use strict;
use warnings;

my $minlen = shift or die "\nThis script filters contig after de novo assembly\n\n\nUsage: \n\n\$ filter-contig.pl minimumcontiglength FASTA.fasta\n\ne.g. \$ filter-contig.pl 300 ABC.fna\n\n\nAuthor: Raymond Kiu Raymond.Kiu\@quadram.ac.uk\n9 July 2019\n\n";
{
    local $/=">";
    while(<>) {
        chomp;
        next unless /\w/;
        s/>$//gs;
        my @chunk = split /\n/;
        my $header = shift @chunk;
        my $seqlen = length join "", @chunk;
        print ">$_" if($seqlen >= $minlen);
    }
    local $/="\n";
}
