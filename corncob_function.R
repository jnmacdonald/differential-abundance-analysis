#determines the differential abundance of the taxa found in the input
#         ASV, an ASV table with the taxa as rows
#         meta, a meta data table containing the samples and the sample variables
#         sample_var, the variable in the meta table that we want to test if the taxa are differentially abundant over
#         seed, the seed to be set 
##b50cff4e8e12db03d98042749526dabc9ed8a6fe commit id of corncob

diff_test <- function(asv, meta, sample_var, n) {
  ##read in the asv and meta tables
  ASV <- read.table(asv, header=TRUE, check.names = FALSE, row.names=1, sep="\t")
  meta <-read.table(meta, header=TRUE, row.names=1, check.names=FALSE, comment.char = "", quote = "", sep="\t")
  
  ##take the overlapping sample ids in the metadata and asv tables
  overlapping_ids <- colnames(ASV)[which(colnames(ASV) %in% rownames(meta))]
  ASV_ordered <- ASV[, overlapping_ids]
  meta_ordered <- meta[overlapping_ids,, drop=FALSE]
  
  
  ##use the ASV table and metadata table to create phyloseq otu table and sample data, then combine into a phyloseq object
  otu <- otu_table(ASV_ordered, taxa_are_rows = TRUE)
  sam_data <- sample_data(meta_ordered, errorIfNULL = TRUE)
  phylo <-merge_phyloseq(otu,sam_data)
  
  ##creates the formula for the differential test based on the sample_var provided in the input to the function
  my_formula <- as.formula(paste("~", sample_var, sep=" ", collapse=""))
  
  set.seed(n)
  ?differentialTest
  da_analysis <- differentialTest(formula = my_formula,
                                  phi.formula = my_formula,
                                  formula_null = ~ 1,
                                  phi.formula_null = my_formula,
                                  test= "Wald", boot = FALSE,
                                  data = phylo,
                                  fdr_cutoff = 0.05)
  
  
  return(da_analysis$significant_taxa)
}




