#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 10:00:00
#SBATCH -J rna_single_spades
#SBATCH -o rna_single_spades.out
#SBATCH -e rna_single_spades.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load bwa-mem2/2.3-GCC-13.3.0
module load SAMtools/1.22.1-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis
REF=${BASE_DIR}/results/spades/spades_hybrid_contigs.fasta
RNA_SOURCE=/proj/uppmax2026-1-61/Genome_Analysis/1_Zhang_2017/transcriptomics_data
OUTDIR=${BASE_DIR}/mapping/rnaseq_mapping/single_reads/spades

THREADS=4

bwa-mem2 index "$REF"

for SAMPLE in ERR1797972 ERR1797973 ERR1797974
do
  for MATE in 1 2
  do
    READ=${RNA_SOURCE}/RNA-Seq_BH/trimmed/trim_single_${SAMPLE}_pass_${MATE}.fastq.gz
    BAM=${OUTDIR}/BH_${SAMPLE}_single${MATE}_spades.sorted.bam

    bwa-mem2 mem -t "$THREADS" "$REF" "$READ" | \
    samtools sort -@ "$THREADS" -o "$BAM"

    samtools index "$BAM"
    samtools flagstat "$BAM" > ${OUTDIR}/BH_${SAMPLE}_single${MATE}_spades_flagstat.txt
  done
done

for SAMPLE in ERR1797969 ERR1797970 ERR1797971
do
  for MATE in 1 2
  do
    READ=${RNA_SOURCE}/RNA-Seq_Serum/trimmed/trim_single_${SAMPLE}_pass_${MATE}.fastq.gz
    BAM=${OUTDIR}/Serum_${SAMPLE}_single${MATE}_spades.sorted.bam

    bwa-mem2 mem -t "$THREADS" "$REF" "$READ" | \
    samtools sort -@ "$THREADS" -o "$BAM"

    samtools index "$BAM"
    samtools flagstat "$BAM" > ${OUTDIR}/Serum_${SAMPLE}_single${MATE}_spades_flagstat.txt
  done
done

echo "DONE"
