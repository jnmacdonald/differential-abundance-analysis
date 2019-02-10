##runs rfPermute on the Chemerin dataset
setwd("/home/shared/hackathon/tables_and_metadata/Chemerin")
mean_decrease_accuracy<- rfP_test("Chemerin_ASVs_filt_subset.tsv", "Chemerin_metadata.txt", "Facility")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "Chemerin_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs rfPermute on the normal Blueberry dataset
setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
mean_decrease_accuracy<- rfP_test("Blueberry_ASVs_filt_subset.tsv", "map_hackathon_blueberry.txt", "description")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "Blueberry_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs rfPermute on the noLowVar Blueberry dataset
setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
mean_decrease_accuracy<- rfP_test("Blueberry_ASVs_filt_subset_noLowVar.tsv", "map_hackathon_blueberry.txt", "description")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "Blueberry_noLowVar_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs rfPermute on the MALL dataset
setwd("/home/shared/hackathon/tables_and_metadata/MALL")
mean_decrease_accuracy<- rfP_test("MALL_ASVs_filt_subset.tsv", "MALL_simple_metadata.txt", "Infection_in_6")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "MALL_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs rfPermute on the Exercise dataset
setwd("/home/shared/hackathon/tables_and_metadata/Exercise")
mean_decrease_accuracy<- rfP_test("Exercise_ASVs_filt_subset.tsv", "forced_exercise_metadata.txt", "group")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "da_Exercise_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs rfPermute on the BISCUIT dataset
setwd("/home/shared/hackathon/tables_and_metadata/BISCUIT")
mean_decrease_accuracy<- rfP_test("BISCUIT_ASVs_filt_subset.tsv", "BISCUIT_metadata.txt", "disease_state")
saveRDS(da_rfP, "Exercise_rfPermute.rds")
setwd("/home/jocelyn/results/rfPermute")
write.table(mean_decrease_accuracy, "BISCUIT_rfP.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

