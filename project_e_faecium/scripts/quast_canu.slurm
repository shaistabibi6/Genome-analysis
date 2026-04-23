#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J quast_canu
#SBATCH --mem=8G
#SBATCH --mail-type=ALL

module load quast

quast.py \
~/Genome-analysis/project_e_faecium/assembly/canu_assembly/canu_output/efaecium.contigs.fasta \
-o quast_output
