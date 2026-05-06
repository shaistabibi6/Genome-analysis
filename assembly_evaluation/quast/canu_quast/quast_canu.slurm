#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J quast_canu
#SBATCH -o quast_canu.out
#SBATCH -e quast_canu.err

module purge
module load QUAST/5.3.0-gfbf-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

quast.py \
  -o quast_canu_output \
  ${BASE_DIR}/assembly/canu_assembly/canu_output/efaecium.contigs.fasta
