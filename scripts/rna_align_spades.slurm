#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J rna_spades
#SBATCH -o rna_spades.out
#SBATCH -e rna_spades.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load bwa-mem2/2.3-GCC-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

REF=${BASE_DIR}/results/spades/spades_hybrid_contigs.fasta
RNA_DIR=${BASE_DIR}/mapping/rnaseq_mapping/raw_links
OUTDIR=${BASE_DIR}/mapping/rnaseq_mapping/spades

THREADS=4

bwa-mem2 index "$REF"

for SAMPLE in ERR1797972 ERR1797973 ERR1797974
do
    R1=${RNA_DIR}/BH/trim_paired_${SAMPLE}_pass_1.fastq.gz
    R2=${RNA_DIR}/BH/trim_paired_${SAMPLE}_pass_2.fastq.gz
    BAM=${OUTDIR}/BH_${SAMPLE}_spades.sorted.bam

    echo "Mapping BHI sample $SAMPLE to SPAdes assembly"

    bwa-mem2 mem -t "$THREADS" "$REF" "$R1" "$R2" | \
    samtools sort -@ "$THREADS" -o "$BAM"

    samtools index "$BAM"
    samtools flagstat "$BAM" > ${OUTDIR}/BH_${SAMPLE}_spades_flagstat.txt
done

for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
    R1=${RNA_DIR}/Serum/trim_paired_${SAMPLE}_pass_1.fastq.gz
    R2=${RNA_DIR}/Serum/trim_paired_${SAMPLE}_pass_2.fastq.gz
    BAM=${OUTDIR}/Serum_${SAMPLE}_spades.sorted.bam

    echo "Mapping Serum sample $SAMPLE to SPAdes assembly"

    bwa-mem2 mem -t "$THREADS" "$REF" "$R1" "$R2" | \
    samtools sort -@ "$THREADS" -o "$BAM"

    samtools index "$BAM"
    samtools flagstat "$BAM" > ${OUTDIR}/Serum_${SAMPLE}_spades_flagstat.txt
done

echo "DONE"
