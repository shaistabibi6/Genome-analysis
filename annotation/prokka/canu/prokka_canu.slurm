#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 02:00:00
#SBATCH -J prokka_canu
#SBATCH -o prokka_canu.out
#SBATCH -e prokka_canu.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load prokka/1.14.5-gompi-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

INPUT=${BASE_DIR}/results/canu/canu_pacbio_contigs.fasta
OUTDIR=${BASE_DIR}/annotation/prokka/canu/prokka_canu_output

rm -rf "$OUTDIR"


prokka \
  --force \
  --outdir "$OUTDIR" \
  --prefix canu_efaecium \
  --genus Enterococcus \
  --species faecium \
  --strain E745 \
  --kingdom Bacteria \
  --cpus 4 \
  "$INPUT"

echo "DONE"
