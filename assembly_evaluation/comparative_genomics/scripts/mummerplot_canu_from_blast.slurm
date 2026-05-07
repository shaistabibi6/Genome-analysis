#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 02:00:00
#SBATCH -J mummer_canu
#SBATCH -o mummer_canu.out
#SBATCH -e mummer_canu.err
#SBATCH --mail-type=ALL

set -euo pipefail

module purge
module load BLAST+/2.17.0-gompi-2024a
module load MUMmer/4.0.1-GCCcore-13.3.0

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

ASSEMBLY=${BASE_DIR}/results/canu/canu_pacbio_contigs.fasta
BLAST_HITS=${BASE_DIR}/assembly_evaluation/comparative_genomics/blast/canu/canu_blast_hits.tsv
OUTDIR=${BASE_DIR}/assembly_evaluation/comparative_genomics/mummerplot/canu

mkdir -p "$OUTDIR"
cd "$OUTDIR"

BEST_ACCESSION=$(awk -F'\t' 'NR==1 {print $2}' "$BLAST_HITS")
BEST_SPECIES=$(awk -F'\t' 'NR==1 {print $8}' "$BLAST_HITS")
BEST_TITLE=$(awk -F'\t' 'NR==1 {print $9}' "$BLAST_HITS")

REFERENCE_FASTA=canu_closest_reference.fasta
PREFIX=canu_mummerplot

echo "Assembly: $ASSEMBLY"
echo "Best accession: $BEST_ACCESSION"
echo "Best species: $BEST_SPECIES"
echo "Best title: $BEST_TITLE"

blastdbcmd -db nt -entry "$BEST_ACCESSION" -out "$REFERENCE_FASTA"

nucmer --prefix=$PREFIX "$REFERENCE_FASTA" "$ASSEMBLY"

delta-filter -1 ${PREFIX}.delta > ${PREFIX}.filtered.delta

mummerplot \
  --png \
  --layout \
  --filter \
  --prefix=${PREFIX} \
  ${PREFIX}.filtered.delta

{
  echo -e "assembly\t$ASSEMBLY"
  echo -e "blast_hits\t$BLAST_HITS"
  echo -e "best_accession\t$BEST_ACCESSION"
  echo -e "best_species\t$BEST_SPECIES"
  echo -e "best_title\t$BEST_TITLE"
  echo -e "reference_fasta\t$OUTDIR/$REFERENCE_FASTA"
  echo -e "mummer_plot\t$OUTDIR/${PREFIX}.png"
} > canu_mummerplot_summary.tsv

echo "DONE"
