#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 1
#SBATCH -t 02:00:00
#SBATCH -J deseq2_spades
#SBATCH -o deseq2_spades.out
#SBATCH -e deseq2_spades.err
#SBATCH --mail-type=ALL

module purge
module load R/4.5.1-gfbf-2024a

Rscript deseq2_spades.R
