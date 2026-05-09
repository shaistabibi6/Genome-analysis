library(DESeq2)

count_files <- c(
  "../../../read_counts/paired_reads/spades/BH_ERR1797972_spades_counts.tsv",
  "../../../read_counts/paired_reads/spades/BH_ERR1797973_spades_counts.tsv",
  "../../../read_counts/paired_reads/spades/BH_ERR1797974_spades_counts.tsv",
  "../../../read_counts/paired_reads/spades/Serum_ERR1797969_spades_counts.tsv",
  "../../../read_counts/paired_reads/spades/Serum_ERR1797970_spades_counts.tsv",
  "../../../read_counts/paired_reads/spades/Serum_ERR1797971_spades_counts.tsv"
)

sample_names <- c("BH1", "BH2", "BH3", "Serum1", "Serum2", "Serum3")
condition <- factor(c("BH", "BH", "BH", "Serum", "Serum", "Serum"))

count_list <- lapply(count_files, function(x) {
  read.table(x, header = FALSE, row.names = 1)
})

counts <- do.call(cbind, count_list)
colnames(counts) <- sample_names
counts <- counts[!grepl("^__", rownames(counts)), ]

coldata <- data.frame(
  row.names = sample_names,
  condition = condition
)

dds <- DESeqDataSetFromMatrix(
  countData = counts,
  colData = coldata,
  design = ~ condition
)

dds <- DESeq(dds)

res <- results(dds, contrast = c("condition", "Serum", "BH"))
resOrdered <- res[order(res$padj), ]

write.csv(as.data.frame(resOrdered), file = "deseq2_spades_results.csv")

vsd <- vst(dds, blind = FALSE)

pdf("pca_spades.pdf")
plotPCA(vsd, intgroup = "condition")
dev.off()

pdf("ma_spades.pdf")
plotMA(res)
dev.off()

write.csv(counts(dds, normalized = TRUE), file = "normalized_counts_spades.csv")
