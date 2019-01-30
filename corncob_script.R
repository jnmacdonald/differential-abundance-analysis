setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
asv <- "Blueberry_ASVs_filt_subset_noLowVar.tsv"
meta <- "map_hackathon_blueberry.txt"
sample_var <- "description"
da <- diff_test(asv, meta, sample_var, 1)
setwd("/home/jocelyn/results/corncob")
write.table(da, "da_Blueberry_noLowVar_corncob.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
asv <- "Blueberry_ASVs_filt_subset.tsv"
meta <- "map_hackathon_blueberry.txt"
sample_var <- "description"
da <- diff_test(asv, meta, sample_var, 1)
setwd("/home/jocelyn/results/corncob")
write.table(da, "da_Blueberry_corncob.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

setwd("/home/shared/hackathon/tables_and_metadata/Chemerin")
asv <- "Chemerin_ASVs_filt_subset.tsv"
meta <- "Chemerin_metadata.txt"
sample_var <- "Facility"
da <- diff_test(asv, meta, sample_var, 1)
setwd("/home/jocelyn/results/corncob")
write.table(da, "da_Chemerin_corncob.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

setwd("/home/shared/hackathon/tables_and_metadata/MALL")
asv <- "MALL_ASVs_filt_subset.tsv"
meta <- "MALL_simple_metadata.txt"
sample_var <- "Infection_in_6"
da <- diff_test(asv, meta, sample_var, 1)
setwd("/home/jocelyn/results/corncob")
write.table(da, "da_MALL_corncob.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

setwd("/home/shared/hackathon/tables_and_metadata/Exercise")
asv <- "Exercise_ASVs_filt_subset.tsv"
meta <- "forced_exercise_metadata.txt"
sample_var <- "group"
da <- diff_test(asv, meta, sample_var, 1)
setwd("/home/jocelyn/results/corncob")
write.table(da, "da_Exercise_corncob.txt", quote = FALSE, col.names = FALSE, row.names = FALSE)

