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
