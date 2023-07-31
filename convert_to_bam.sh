#!/bin/sh
for i in ./mapped_reads/*.sam
do
    base=$(basename $i .sam)
    samtools view -bS $i > ./BAM_files/$base.bam
done