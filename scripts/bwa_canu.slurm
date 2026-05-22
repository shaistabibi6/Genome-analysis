#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 01:00:00
#SBATCH -J bwa_canu
#SBATCH -o bwa_canu.out
#SBATCH -e bwa_canu.err
#SBATCH --mail-type=ALL

module purge
module load BWA/0.7.18-GCCcore-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

REF=${BASE_DIR}/results/canu/canu_pacbio_contigs.fasta
R1=${BASE_DIR}/raw_data/genome_reads/illumina/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
R2=${BASE_DIR}/raw_data/genome_reads/illumina/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz

bwa index "$REF"

bwa mem -t 4 "$REF" "$R1" "$R2" | \
samtools sort -@ 4 -o canu_illumina_mapped.sorted.bam

samtools index canu_illumina_mapped.sorted.bam
samtools flagstat canu_illumina_mapped.sorted.bam > canu_illumina_mapping_flagstat.txt

echo "DONE"
