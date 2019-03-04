source('~/final_scripts/DeSeq2_function.R')

#Chemerin
setwd("/home/jocelyn/results/DeSeq2/Chemerin")
run_DeSeq2("/home/shared/hackathon/tables_and_metadata/Chemerin/Chemerin_ASVs_filt_subset.tsv", "/home/shared/hackathon/tables_and_metadata/Chemerin/Chemerin_metadata.txt", "Facility")

#BISCUIT
setwd("/home/jocelyn/results/DeSeq2/BISCUIT")
run_DeSeq2("/home/jocelyn/results/BISCUIT_ASVs_filt_subset.biom.tsv", "/home/jocelyn/results/ALDEx2/B_metadata.txt", "disease_state")

#Blueberry
setwd("/home/jocelyn/results/DeSeq2/Blueberry")
run_DeSeq2("/home/shared/hackathon/tables_and_metadata/Blueberry/Blueberry_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/Blueberry/map_hackathon_blueberry.txt",
            "description")
#Blueberry filtered
setwd("/home/jocelyn/results/DeSeq2/BlueberryFiltered")
run_DeSeq2("/home/shared/hackathon/tables_and_metadata/Blueberry/Blueberry_ASVs_filt_subset_rare_noLowVar.tsv",
           "/home/shared/hackathon/tables_and_metadata/Blueberry/map_hackathon_blueberry.txt",
           "description")
#MALL
setwd("/home/jocelyn/results/DeSeq2/MALL")
run_DeSeq2("/home/shared/hackathon/tables_and_metadata/MALL/MALL_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/MALL/MALL_simple_metadata.txt",
            "Infection_in_6")

#Exercise
setwd("/home/jocelyn/results/DeSeq2/Exercise")
run_DeSeq2("/home/shared/hackathon/tables_and_metadata/Exercise/Exercise_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/Exercise/forced_exercise_metadata.txt",
            "group")

