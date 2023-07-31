# #!/bin/sh
for i in ./BAM_files/*.bam
do
    base=$(basename $i .bam)
    samtools sort $i -o ./sorted_bam/$base.sorted.bam
done