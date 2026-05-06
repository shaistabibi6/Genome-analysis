#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 12:00:00
#SBATCH -J spades_hybrid
#SBATCH -o spades_%j.out
#SBATCH -e spades_%j.err
#SBATCH --mem=64G
#SBATCH --mail-type=ALL

module purge
module load SPAdes/4.2.0-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

ILLUMINA_DIR=${BASE_DIR}/raw_data/genome_reads/illumina
PACBIO_DIR=${BASE_DIR}/raw_data/genome_reads/pacbio
OUT_DIR=${BASE_DIR}/assembly/hybrid_spades

R1=${ILLUMINA_DIR}/E745-1.L500_SZAXPI015146-56_1_clean.fq.gz
R2=${ILLUMINA_DIR}/E745-1.L500_SZAXPI015146-56_2_clean.fq.gz
PACBIO=${PACBIO_DIR}/pacbio_all.fastq.gz

mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

rm -rf spades_output

echo "Checking input files:"
ls -lh "$R1"
ls -lh "$R2"
ls -lh "$PACBIO"

echo "Starting hybrid SPAdes assembly..."

spades.py \
  --pe1-1 "$R1" \
  --pe1-2 "$R2" \
  --pacbio "$PACBIO" \
  -t 2 \
  -m 60 \
  -o spades_output

echo "DONE"
