#!/bin/sh
for i in ./sorted_bam/*sorted.bam
do
    base=$(basename $i .bam)
    samtools index ./sorted_bam/$base.bam ./sorted_bam_index/$base.sorted.bam.bai
done