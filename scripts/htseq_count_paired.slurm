#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 05:00:00
#SBATCH -J htseq_paired
#SBATCH -o htseq_paired.out
#SBATCH -e htseq_paired.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load HTSeq/2.1.2-gfbf-2024a
module load SAMtools/1.22.1-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis
COUNT_DIR=${BASE_DIR}/expression_analysis/read_counts/paired_reads

CANU_OUT=${COUNT_DIR}/canu
SPADES_OUT=${COUNT_DIR}/spades

mkdir -p "$CANU_OUT" "$SPADES_OUT"

BH_REPLICATES=("ERR1797972" "ERR1797973" "ERR1797974")
SERUM_REPLICATES=("ERR1797969" "ERR1797970" "ERR1797971")

CANU_BAM_DIR=${BASE_DIR}/mapping/rnaseq_mapping/canu
SPADES_BAM_DIR=${BASE_DIR}/mapping/rnaseq_mapping/spades

CANU_GFF=${BASE_DIR}/annotation/prokka/canu/prokka_canu_output/canu_efaecium.gff
SPADES_GFF=${BASE_DIR}/annotation/prokka/spades/prokka_spades_output/spades_efaecium.gff

CANU_GFF_CLEAN=${CANU_OUT}/canu_efaecium_no_fasta.gff
SPADES_GFF_CLEAN=${SPADES_OUT}/spades_efaecium_no_fasta.gff

awk '/^##FASTA/ {exit} {print}' "$CANU_GFF" > "$CANU_GFF_CLEAN"
awk '/^##FASTA/ {exit} {print}' "$SPADES_GFF" > "$SPADES_GFF_CLEAN"

for SAMPLE in "${BH_REPLICATES[@]}"; do
    BAM=${CANU_BAM_DIR}/BH_${SAMPLE}_canu.sorted.bam
    OUT=${CANU_OUT}/BH_${SAMPLE}_canu_counts.tsv

    htseq-count --format=bam --order=pos --stranded=reverse --type=CDS --idattr=ID \
      "$BAM" "$CANU_GFF_CLEAN" > "$OUT"
done

for SAMPLE in "${SERUM_REPLICATES[@]}"; do
    BAM=${CANU_BAM_DIR}/Serum_${SAMPLE}_canu.sorted.bam
    OUT=${CANU_OUT}/Serum_${SAMPLE}_canu_counts.tsv

    htseq-count --format=bam --order=pos --stranded=reverse --type=CDS --idattr=ID \
      "$BAM" "$CANU_GFF_CLEAN" > "$OUT"
done

for SAMPLE in "${BH_REPLICATES[@]}"; do
    BAM=${SPADES_BAM_DIR}/BH_${SAMPLE}_spades.sorted.bam
    OUT=${SPADES_OUT}/BH_${SAMPLE}_spades_counts.tsv

    htseq-count --format=bam --order=pos --stranded=reverse --type=CDS --idattr=ID \
      "$BAM" "$SPADES_GFF_CLEAN" > "$OUT"
done

for SAMPLE in "${SERUM_REPLICATES[@]}"; do
    BAM=${SPADES_BAM_DIR}/Serum_${SAMPLE}_spades.sorted.bam
    OUT=${SPADES_OUT}/Serum_${SAMPLE}_spades_counts.tsv

    htseq-count --format=bam --order=pos --stranded=reverse --type=CDS --idattr=ID \
      "$BAM" "$SPADES_GFF_CLEAN" > "$OUT"
done

echo "DONE"
