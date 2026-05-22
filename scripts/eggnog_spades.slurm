#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 13:00:00
#SBATCH -J eggnog_spades
#SBATCH -o eggnog_spades.out
#SBATCH -e eggnog_spades.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load eggnog-mapper/2.1.13-gfbf-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

INPUT=${BASE_DIR}/annotation/prokka/spades/prokka_spades_output/spades_efaecium.faa
OUTDIR=${BASE_DIR}/annotation/eggnog/spades/eggnog_spades_output
DBDIR=${BASE_DIR}/annotation/eggnog/resources/eggnog-mapper/rackham

rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

emapper.py \
  -i "$INPUT" \
  --itype proteins \
  --output spades_eggnog \
  --output_dir "$OUTDIR" \
  --data_dir "$DBDIR" \
  --cpu 4

echo "DONE"
