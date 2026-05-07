#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J prokka_spades
#SBATCH -o prokka_spades.out
#SBATCH -e prokka_spades.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load prokka/1.14.5-gompi-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

INPUT=${BASE_DIR}/results/spades/spades_hybrid_contigs.fasta
OUTDIR=${BASE_DIR}/annotation/prokka/spades/prokka_spades_output

rm -rf "$OUTDIR"

prokka \
  --force \
  --outdir "$OUTDIR" \
  --prefix spades_efaecium \
  --genus Enterococcus \
  --species faecium \
  --strain E745 \
  --kingdom Bacteria \
  --cpus 4 \
  "$INPUT"

echo "DONE"
