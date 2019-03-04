
ALDEx2_function <- function(asv, meta, sample_var) { 
  ASV <- read.table(asv, sep="\t", header=T, row.names=1, comment.char="", quote="", check.names=F, stringsAsFactors = F)
  meta <- read.table(meta, sep="\t", row.names=1, header=T, comment.char="", quote="", check.names=F, stringsAsFactors = F)
  overlapping_ids <- colnames(ASV)[which(colnames(ASV) %in% rownames(meta))]
  ASV_ordered <- ASV[, overlapping_ids]
  meta_ordered <- meta[overlapping_ids,, drop=FALSE]
  conditions <- meta_ordered$disease_state
  res <- aldex(ASV, conditions = conditions, mc.samples = 128, test="t")
  alpha <- 0.05
  sig_hits <- res[which(res$wi.eBH < alpha),]
  return(rownames(sig_hits))
}
