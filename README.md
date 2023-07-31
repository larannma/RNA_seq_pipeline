# RNA_seq_pipeline

Download data from [NCBI](https://www.ncbi.nlm.nih.gov/sra)
<br> Presentation https://docs.google.com/presentation/d/1NR97b0Y6AMtWCuncW1QIQBa5SIeePwFtloGDQU6ccQM/edit?usp=sharing

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

<p>Create a genome index</p>

```
hisat2-build /path/to/hg38.p13.fa hg38_index
```

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
# #!/bin/sh
for i in ./BAM_files/*.bam
do
    base=$(basename $i .bam)
    samtools sort $i -o ./sorted_bam/$base.sorted.bam
done
```

```
#!/bin/sh
for i in ./sorted_bam/*sorted.bam
do
    base=$(basename $i .bam)
    samtools index ./sorted_bam/$base.bam ./sorted_bam_index/$base.sorted.bam.bai
done
```

<h1>Gene expression</h1>
<p>Script that uses htseq-count to calculate gene expression from sorted BAM files</p>

```
#!/bin/sh
GTF="./annotation/my_annotations.gtf"
for i in ./sorted_bam/*.bam
do
    base=$(basename $i .bam)
    htseq-count -f bam -s no $i $GTF > ./htseq_output/${base}_counts.txt
done
```
<h1>Identification of the top 5k maximally variable genes</h1>


