#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 4
#SBATCH -t 13:00:00
#SBATCH -J eggnog_canu
#SBATCH -o eggnog_canu.out
#SBATCH -e eggnog_canu.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load eggnog-mapper/2.1.13-gfbf-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

INPUT=${BASE_DIR}/annotation/prokka/canu/prokka_canu_output/canu_efaecium.faa
OUTDIR=${BASE_DIR}/annotation/eggnog/canu/eggnog_canu_output
DBDIR=${BASE_DIR}/annotation/eggnog/resources/eggnog-mapper/rackham

rm -rf "$OUTDIR"
mkdir -p "$OUTDIR"

emapper.py \
  -i "$INPUT" \
  --itype proteins \
  --output canu_eggnog \
  --output_dir "$OUTDIR" \
  --data_dir "$DBDIR" \
  --cpu 4

echo "DONE"
