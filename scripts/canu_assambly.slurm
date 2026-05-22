#!/bin/bash
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 24:00:00
#SBATCH -J canu_assembly
#SBATCH -e canu_%j.err
#SBATCH -o canu_%j.out
#SBATCH --mem=64G
#SBATCH --mail-type=ALL

module purge
module load canu
module load SAMtools/1.22.1-GCC-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis
RAW_DATA=${BASE_DIR}/raw_data/genome_reads/pacbio
OUT_DIR=${BASE_DIR}/assembly/canu_assembly

mkdir -p "$OUT_DIR"
cd "$OUT_DIR"

echo "Checking PacBio reads:"
ls -lh "$RAW_DATA"

READS=$(find "$RAW_DATA" -maxdepth 1 -name "*.fastq.gz" | sort)

echo "PacBio reads found:"
echo "$READS"

if [ -z "$READS" ]; then
    echo "ERROR: No PacBio reads found."
    exit 1
fi

rm -rf canu_output

echo "Starting Canu assembly..."

canu \
  -p efaecium \
  -d canu_output \
  genomeSize=3m \
  useGrid=false \
  maxThreads=2 \
  corThreads=2 \
  -pacbio $READS

echo "DONE"
