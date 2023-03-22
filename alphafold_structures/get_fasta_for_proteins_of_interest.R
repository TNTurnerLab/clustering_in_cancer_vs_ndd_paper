#!/bin/Rscript
# Tychele N. Turner, Ph.D.
# Last update: March 21, 2023
# pull out fasta sequences from protein reference fasta file for proteins of interest

library('seqinr')

fasta <- read.fasta("GRCh38_latest_protein.faa.gz", forceDNAtolower=FALSE)

# this file just has one protein id per line
matcher <- read.delim("proteins.txt", header=F)

for(i in 1:nrow(matcher)){
    write.fasta(fasta[which(attr(fasta, "name") == as.character(matcher$V1[i]))], file=paste(as.character(matcher$V1[i]), ".fasta", sep=""), names=as.character(matcher$V1[i]))
}
