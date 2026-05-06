#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J prokka_canu
#SBATCH -o prokka.out
#SBATCH -e prokka.err

module load prokka/1.14.5-gompi-2024a

prokka \
--outdir prokka_canu \
--prefix efaecium \
--cpus 2 \
../../assembly/canu_assembly/canu_output/efaecium.contigs.fasta
