#!/bin/bash
for file in *.fastq.gz
do
    echo "Trimming ${file}"
    trim_galore ${file}
done

mkdir trimmed_reads
mv *_trimmed.fq.gz trimmed_reads/

echo "Trimming has been completed."