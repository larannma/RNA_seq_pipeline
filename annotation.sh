#!/bin/sh
GTF="./annotation/my_annotations.gtf"
for i in ./sorted_bam/*.bam
do
    base=$(basename $i .bam)
    htseq-count -f bam -s no $i $GTF > ./htseq_output/${base}_counts.txt
done