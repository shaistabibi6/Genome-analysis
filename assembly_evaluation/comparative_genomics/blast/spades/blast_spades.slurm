#!/bin/bash -l
#SBATCH -A uppmax2026-1-61
#SBATCH -p pelle
#SBATCH -n 2
#SBATCH -t 20:00:00
#SBATCH -J blast_spades
#SBATCH -o blast_spades.out
#SBATCH -e blast_spades.err
#SBATCH --mail-type=ALL

module purge
module load BLAST+/2.17.0-gompi-2024a

BASE_DIR=/proj/uppmax2026-1-61/nobackup/shais/efaecium_genome_analysis

QUERY=${BASE_DIR}/results/spades/spades_hybrid_contigs.fasta
OUTDIR=${BASE_DIR}/assembly_evaluation/comparative_genomics/blast/spades

cd "$OUTDIR"

blastn \
  -task megablast \
  -query "$QUERY" \
  -db nt \
  -num_threads 2 \
  -max_target_seqs 20 \
  -max_hsps 1 \
  -perc_identity 80 \
  -qcov_hsp_perc 50 \
  -evalue 1e-20 \
  -outfmt "6 qseqid sseqid pident length evalue bitscore staxids sscinames stitle" \
  -out spades_blast_hits.tsv

head spades_blast_hits.tsv > spades_top_hits_preview.txt

echo "DONE"
