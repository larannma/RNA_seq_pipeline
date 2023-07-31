#!/bin/sh
for i in ./trimmed_reads/*.gz
do
    base=$(basename $i .gz)
    hisat2 -x hg38_index -U $i -S ./mapped_reads/$base.sam
done