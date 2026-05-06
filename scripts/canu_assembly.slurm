#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH -J canu_assembly
#SBATCH -e canu_%j.err
#SBATCH -o canu_%j.out
#SBATCH --mem=64G
#SBATCH --mail-type=ALL

module purge
module load canu
module load SAMtools

# Base directory
BASE_DIR=~/Genome-analysis/project_e_faecium

RAW_DATA=$BASE_DIR/raw_data/genome_reads/pacbio
OUT_DIR=$BASE_DIR/assembly/canu_assembly

mkdir -p $OUT_DIR
cd $OUT_DIR

# Get reads
READS=$(ls $RAW_DATA/*.fastq.gz)

echo "Using these input files:"
echo $READS

# Run Canu
canu \
 -p efaecium \
 -d canu_output \
 genomeSize=3m \
 useGrid=false \
 maxThreads=2 \
 corThreads=2 \
 -pacbio $READS

echo "DONE"
