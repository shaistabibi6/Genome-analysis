# Repository Organization

This repository is organized according to different stages of the genome analysis workflow.

| Section | Description |
|---|---|
| `Quality Control and Preprocessing` | FastQC analysis and preprocessing of sequencing reads |
| `Genome and Metagenome Assembly` | Canu assembly and hybrid SPAdes assembly workflow, including answers for Grade 4/5 hybrid assembly questions |
| `Assembly Evaluation` | QUAST, BUSCO, and MUMmerplot analyses, including answers for Grade 4/5 assembly evaluation questions |
| `Annotation` | Prokka genome annotation results |
| `Mapping` | BWA genome mapping and RNA-seq alignment |
| `Read counting` | HTSeq read quantification |
| `Differential Expression Analysis` | DESeq2 analysis and interpretation of differentially expressed genes |
| `Review of Zhang et al. (2017)` | Literature review and comparison with the published study |
| `scripts/` | SLURM scripts used throughout the workflow |

---

# Workflow Summary

The project workflow included:

1. Quality control of Illumina and PacBio sequencing reads  
2. Genome assembly using:
   - Canu (PacBio long-read assembly)
   - Hybrid SPAdes (PacBio + Illumina hybrid assembly)
3. Assembly evaluation using:
   - QUAST
   - BUSCO
   - MUMmerplot
4. Genome annotation using Prokka
5. Comparative genomics and synteny analysis
6. RNA-seq mapping and read counting
7. Differential gene expression analysis using DESeq2

---

# Assignment Question Locations

| Topic | Location |
|---|---|
| Hybrid assembly Grade 4/5 questions | `Genome and Metagenome Assembly` |
| Assembly evaluation Grade 4/5 questions | `Assembly Evaluation` |
| BUSCO and MUMmerplot extra analysis | `Assembly Evaluation` |
| RNA-seq and differential expression analysis | `Differential Expression Analysis` |
