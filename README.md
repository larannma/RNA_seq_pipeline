# RNA_seq_pipeline

Downloading data from [NCBI](https://www.ncbi.nlm.nih.gov/sra)

<h1>Trimming</h1>
<p>Following script will trim and remove adapters for each of the files and save the result in a new folder.</p>

```
for file in *.fastq.gz
do
    echo "Trimming ${file}"
    trim_galore ${file}
done

mkdir trimmed_reads
mv *_trimmed.fq.gz trimmed_reads/

echo "Trimming has been completed."
```
<h1>Mapping on genome (hg38.p13)</h1>
<p>Mapping RNA-seq reads to a reference genome using the hisat2 program</p>

```
#!/bin/sh
for i in ./trimmed_reads/*.gz
do
    base=$(basename $i .gz)
    hisat2 -x hg38_index -U $i -S ./mapped_reads/$base.sam
done
```
<h1>Post-mapping</h1>
<p>Сonverting sam them to BAM (Binary Alignment/Map) format</p>

```
#!/bin/sh
for i in ./mapped_reads/*.sam
do
    base=$(basename $i .sam)
    samtools view -bS $i > ./BAM_files/$base.bam
done
```
<p>Sorting and indexing of BAM files</p>

```
#!/bin/sh
for i in ./sorted_bam/*sorted.bam
do
    base=$(basename $i .bam)
    samtools index ./sorted_bam/$base.bam ./sorted_bam_index/$base.sorted.bam.bai
done
```
