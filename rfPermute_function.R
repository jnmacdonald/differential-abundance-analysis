#Uses rfPermute to create a null distribution of predictor variables , produces significant predictor variables with their mean decrease in accuracy
rfP_test <- function(asv, meta, sample_var) {
  ##read in the asv and meta tables
  ASV <- read.table(asv, header=TRUE, check.names = FALSE, row.names=1, sep="\t")
  meta <-read.table(meta, header=TRUE, row.names=1, check.names=FALSE, comment.char = "", quote = "", sep="\t")
  
  ##take the overlapping sample ids in the metadata and asv tables
  overlapping_ids <- colnames(ASV)[which(colnames(ASV) %in% rownames(meta))]
  ASV_ordered <- ASV[, overlapping_ids]
  ASV_ordered <- t(ASV_ordered)
  meta_ordered <- meta[overlapping_ids,, drop=FALSE]
  
  #runs rfPermute with the asv table as the predicted variables, and the column of the metadata table as the response variable
  da_rfP <- rfPermute(ASV_ordered, y=meta_ordered$description, ntree = 500, na.action = na.omit, nrep = 100)
  setwd("/home/jocelyn/results/rfPermute")
  saveRDS(da_rfP, "Blueberry_noLowVar_rfPermute.rds")
  
  ##creates a data frame containing the scaled p values
  tmp2 <- data.frame(da_rfP$pval[, , "scaled"])
  ##finds the number of values that have a mean deacrease in accuracy less than 0.05, then finds the row numbers of all these values
  len <- length(which(tmp2[ , "MeanDecreaseAccuracy"] < 0.05))
  rows <- which(tmp2[ , "MeanDecreaseAccuracy"] < 0.05)
  
  ##a subsetted table of tmp2 is created to contain only the values that have a meanDecreaseAccuracy less than 0.05
  sub_tmp <- tmp2[(tmp2$MeanDecreaseAccuracy < 0.05),]
  nameRows <- row.names(tmp2[rows,])
  nameRows
  length(nameRows)
  result <- data.frame(matrix(nrow=len))
  rownames(result) <- nameRows
  colnames(result) <- "MeanDecreaseAccuracy"
  ##the final subsetted table contains the predicted values with their meanDecreaseAccuracy less than 0.05
  result$MeanDecreaseAccuracy<- sub_tmp$MeanDecreaseAccuracy
  return(result)
}