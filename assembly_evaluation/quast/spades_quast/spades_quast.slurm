#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J quast_spades
#SBATCH -o quast_spades.out
#SBATCH -e quast_spades.err

module purge
module load QUAST/5.3.0-gfbf-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

quast.py \
  -o quast_spades_output \
  ${BASE_DIR}/assembly/hybrid_spades/spades_output/contigs.fasta
