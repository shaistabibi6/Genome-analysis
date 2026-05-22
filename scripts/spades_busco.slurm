#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 04:00:00
#SBATCH -J busco_spades
#SBATCH -o busco_spades.out
#SBATCH -e busco_spades.err
#SBATCH --mem=32G

module purge
module load BUSCO/5.8.2-gfbf-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

ASSEMBLY=${BASE_DIR}/assembly/hybrid_spades/spades_output/contigs.fasta

busco \
  -i "$ASSEMBLY" \
  -o busco_spades_output \
  -m genome \
  --auto-lineage-prok \
  -c 2 \
  -f

echo "DONE"
