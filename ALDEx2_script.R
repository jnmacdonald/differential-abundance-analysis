source("~/final_scripts/ALDEx2_function.R")

##runs ALDEx2 on the Chemerin dataset
setwd("/home/shared/hackathon/tables_and_metadata/Chemerin")
ALDEx2 <- ALDEx2_function("Chemerin_ASVs_filt_subset.tsv", "Chemerin_metadata.txt", "Facility")
setwd("/home/jocelyn/results/ALDEx2")
write.table(ALDEx2, "Chemerin_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs ALDEx2 on the normal Blueberry dataset
setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
ALDEx2 <- ALDEx2_function("Blueberry_ASVs_filt_subset.tsv", "map_hackathon_blueberry.txt", "description")
setwd("/home/jocelyn/results/ALDex2")
write.table(ALDex2, "Blueberry_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs ALDEx2 on the noLowVar Blueberry dataset
setwd("/home/shared/hackathon/tables_and_metadata/Blueberry")
ALDEx2 <- ALDEx2_function("Blueberry_ASVs_filt_subset_noLowVar.tsv", "map_hackathon_blueberry.txt", "description")
setwd("/home/jocelyn/results/ALDEx2")
write.table(ALDEx2, "Blueberry_noLowVar_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs ALDEx2 on the MALL dataset
setwd("/home/shared/hackathon/tables_and_metadata/MALL")
ALDEx2 <- ALDEx2_function("MALL_ASVs_filt_subset.tsv", "MALL_simple_metadata.txt", "Infection_in_6")
setwd("/home/jocelyn/results/ALDEx2")
write.table(ALDEx2, "MALL_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs ALDEx2 on the Exercise dataset
setwd("/home/shared/hackathon/tables_and_metadata/Exercise")
ALDEx2<- ALDEx2_function("Exercise_ASVs_filt_subset.tsv", "forced_exercise_metadata.txt", "group")
setwd("/home/jocelyn/results/ALDEx2")
write.table(ALDEx2, "da_Exercise_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)

##runs ALDEx2 on the BISCUIT dataset
ALDEx2<- ALDEx2_function("/home/jocelyn/results/BISCUIT_ASVs_filt_subset.biom.tsv", "/home/jocelyn/results/ALDEx2/B_metadata.txt", "disease_state")
setwd("/home/jocelyn/results/ALDEx2")
write.table(ALDEx2, "BISCUIT_ALDEx2.txt", quote = FALSE, col.names = TRUE, row.names = TRUE)
