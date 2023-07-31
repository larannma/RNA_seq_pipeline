#!/bin/bash

for file in samples/*.fastq.gz
do
    echo "Running FastQC on raw read: ${file}"
    fastqc -o raw_fastqc ${file}
done