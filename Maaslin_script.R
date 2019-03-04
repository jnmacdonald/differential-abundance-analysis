source("~/maaslin_function.R")

#Chemerin
run_maaslin("/home/shared/hackathon/tables_and_metadata/Chemerin/Chemerin_ASVs_filt_subset.tsv", 
            "/home/shared/hackathon/tables_and_metadata/Chemerin/Chemerin_metadata.txt", 
            "/home/jocelyn/results/Maaslin/Chemerin")

#Blueberry filtered 
run_maaslin("/home/shared/hackathon/tables_and_metadata/Blueberry/Blueberry_ASVs_filt_subset_rare_noLowVar.tsv",
             "/home/shared/hackathon/tables_and_metadata/Blueberry/map_hackathon_blueberry.txt",
             "/home/jocelyn/results/Maaslin/BlueberryFiltered")

#Blueberry 
run_maaslin("/home/shared/hackathon/tables_and_metadata/Blueberry/Blueberry_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/Blueberry/map_hackathon_blueberry.txt",
            "/home/jocelyn/results/Maaslin/Blueberry")

#BISCUIT
run_maaslin("/home/jocelyn/results/BISCUIT_ASVs_filt_subset.biom.tsv", 
            "/home/shared/hackathon/tables_and_metadata/BISCUIT/BISCUIT_metadata.txt", 
            "/home/jocelyn/results/Maaslin/BISCUIT", "Crohn's disease", "CD", 4)

#MALL
run_maaslin("/home/shared/hackathon/tables_and_metadata/MALL/MALL_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/MALL/MALL_simple_metadata.txt",
            "/home/jocelyn/results/Maaslin/MALL")

#Exercise
run_maaslin("/home/shared/hackathon/tables_and_metadata/Exercise/Exercise_ASVs_filt_subset.tsv",
            "/home/shared/hackathon/tables_and_metadata/Exercise/forced_exercise_metadata.txt",
            "/home/jocelyn/results/Maaslin/Exercise")

