#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -n 2
#SBATCH -t 05:00:00
#SBATCH -J busco_canu
#SBATCH -o busco.out
#SBATCH -e busco.err

module load BUSCO/5.8.2-gfbf-2024a

busco \
-i ../../assembly/canu_assembly/canu_output/efaecium.contigs.fasta \
-o busco_canu \
-l /sw/data/local/BUSCO_Data/v5/lineages/bacteria_odb10 \
-m genome \
--cpu 2
