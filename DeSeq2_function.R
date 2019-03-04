
run_DeSeq2 <- function(asv,meta, sample_var){
  counts <- read.table(asv, sep="\t", row.names = 1, comment.char="", quote="", header=T, check.names=F)
  metadata <- read.table(meta, sep="\t", row.names = 1, header=T, comment.char="", check.names = F)
  col_data <- which( colnames(metadata)==sample_var )
  colnames(metadata)[col_data] <- "grouping"
  
  metadata$Dup <- metadata$grouping
  
  ##take the overlapping sample ids in the metadata and asv tables
  overlapping_ids <- colnames(counts)[which(colnames(counts) %in% rownames(metadata))]
  ASV_ordered <- counts[, overlapping_ids]
  meta_ordered <- metadata[overlapping_ids,, drop=FALSE]
  #rownames(metadata) <- paste0("X",rownames(metadata))

  
  dds <- DESeqDataSetFromMatrix(countData = counts,
                                colData = meta_ordered,
                                design = ~ grouping)
  mid_dds <- DESeq(dds, sfType = "poscounts")
  
  mid_res <- results(mid_dds)
  
  resultsNames(mid_dds)
  mid_res = mid_res[order(mid_res$padj, na.last=NA), ]
  alpha = 0.05
  sighits <- mid_res[(mid_res$padj < alpha),]
  sighits
  sig_hits <- rownames(sighits)
  write.table(sig_hits, "Deseq2_results.txt", quote = FALSE, col.names = FALSE, row.names = TRUE, sep="\t")

}


