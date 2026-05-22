#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J deseq2_canu
#SBATCH -o deseq2_canu.out
#SBATCH -e deseq2_canu.err
#SBATCH --mail-type=ALL

module purge
module load R/4.5.1-gfbf-2024a

Rscript deseq2_canu.R
