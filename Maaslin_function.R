# takes in an asv table, metadata table, and a directory to output the files to, requires the library limma
# other variables are:
#     change_data, default is NULL, this is set to true if the metadata column contains any special characters
#     new_data, default is FALSE, this is set to the value of the new value without special characters
#     col_meta, default is 2. This is the column number that contains the metadata that will be used
run_maaslin <- function(asv,met,output_dir, change_data=NULL, new_data = NULL, col_meta=2) {
  #reads in the input files
  setwd(output_dir)
  ASV <- read.table(asv, header=TRUE, row.names = 1, check.names = FALSE, sep="\t", comment.char="", stringsAsFactors = FALSE, quote="")
  meta <-read.table(met, header=TRUE, row.names=1, check.names=FALSE, comment.char = "", quote = "", sep="\t", stringsAsFactors = FALSE)
  
  #take the overlapping sample ids in the metadata and asv tables
  overlapping_ids <- colnames(ASV)[which(colnames(ASV) %in% rownames(meta))]
  ASV_ordered <- ASV[, c(overlapping_ids)]
  
  #merges the ordered ASV and meta tables into one to fit Maaslin format
  df <- data.frame(b = runif(6), c = rnorm(6))
  ASV_ordered <-cbind(asv = ASV[,1], ASV_ordered)
  ASV_ordered[, overlapping_ids] <- data.frame(sweep(ASV_ordered[, overlapping_ids], 2, colSums(ASV_ordered[, overlapping_ids]), '/'))
  colnames(ASV_ordered)[1] <- "ID"
  ASV_ordered$ID <- gsub("^", "X", ASV_ordered$ID)
  meta_ordered <- meta[overlapping_ids,, drop=FALSE]
  colnames(meta_ordered)[col_meta -1] <- "state"
  state_row <- ASV_ordered[1,, drop=FALSE]
  
  #check to see if there is metadata that needs to be changed, if so, replaces the specified data with the new data given at function call
  if(!(is.null(change_data))){
  meta_ordered$clean_state <- gsub(change_data, new_data, meta_ordered$state)
  
  }else {
    meta_ordered$clean_state <- meta_ordered$state
  }
  
  state_row[1,] <- c("grouping", meta_ordered$clean_state)
  
  ##creates the final input table and writes it to a file
  maaslin_input <- data.frame(t(rbind(state_row, ASV_ordered)))
  write.table(maaslin_input, "input.txt", quote = FALSE, col.names = FALSE, row.names = TRUE, sep="\t")
  
  # calls the sub_input_file function that will run Maaslin on a subset of 99 taxa at a time and combine all the significant features, 
  # then writes the final output to a file
  final_out <- run_on_subset(output_dir)
  write.table(final_out, "final_maaslin_output.txt", quote = FALSE, col.names = FALSE, row.names = TRUE, sep="\t")
  
}

# Separates the Maaslin input file into chunks, so that only 99 taxa are run at once
# results from each Maaslin run are combined with a multiple test correction test
run_on_subset <- function(output_dir) {
  output <- data.frame()
  input <<-read.table("input.txt", header=F,check.names=F,comment.char = "", quote = "", sep="\t", stringsAsFactors = FALSE)

  #checks the dimensions of the input table to determine how many times in must take groups of 99
  i <- input[,1:2]
  d <- dim(input)
  cols <- d[2]
  n <- as.integer((cols/99))
  
  #to ensure all taxa are covered, if n is not 1, 1 is added to cover the rounding done by as.integer()
  if(n!= 1) 
    n <- n + 1
  
  #if the file has less than 99 columns it will take all taxa in at once, otherwise, it will take the first 99
  if(d[2] < 99){
    sub_maaslin_input(3, d[2])
  }else if(d[2] > 99){
    sub_maaslin_input(3, 101)
  }
  
  Maaslin("in.txt","maaslin_output", strInputConfig ="input.read.config")

  direc <- paste(output_dir, "maaslin_output", sep="/")
  output <- check_sig_hits(output, direc, output_dir)
  
  #stop is a variable that keeps track of where the last chunk of 99 taxa ended
  stop <- 101
  for(x in 2:n) {
    #if x is not at n, 99 taxa will be used, from stop+1 to stop + 99
    if(x!=n) {
      sub_maaslin_input(stop+1, stop+100)
      stop <- stop+100
    
      Maaslin("in.txt",
              "maaslin_output",
              strInputConfig ="input.read.config")
    
      #looks in the maaslin_output for the file containing significant features
      output <- check_sig_hits(output, direc, output_dir)
    }  
    #if x equals n, then there is 99 or less taxa left and will therefore take the taxa from the last stop, until the end
    else if(x==n) {
      sub_maaslin_input(stop, d[2])
      
      Maaslin("in.txt",
              "maaslin_output",
              strInputConfig ="input.read.config")
      
      #looks for significant hits
      output <- check_sig_hits(output, direc, output_dir)
    }
  }
  
  # performs the multiple test correction on each of the outputs from Maaslin to create the final adjusted p-values, 
  # and then extracts the most significant ones (p < 0.05) to return
  adjusted <- p.adjust(output$`P-value`)
  output$`P-value` <- adjusted
  #finds the number of values that have a P-value less than 0.05, then finds the row numbers of all these values
  len <- length(which(output[ , "P-value"] < 0.05))
  rows <- which(output[ , "P-value"] < 0.05)
  
  #a subsetted table of output is created to contain only the values that have a P-value less than 0.05
  sub_output <- output[(output$`P-value` < 0.05),]
  
  return(sub_output)
}

#creates the read.config file by extracting the first and last taxa to be read from i, and writes the file to "input.read.config"
make_config <- function(i) {
  #creates the read.config file
  firstTaxa <- i[1,3]
  lastTaxa <- i[1,(dim(i)[2])]
  config <- "Matrix: Metadata\nRead_PCL_Rows: -grouping\n\nMatrix: Abundance\nRead_PCL_Rows: "
  config <- paste(config, firstTaxa, sep = "")
  config <- paste(config, lastTaxa, sep="-")
  write.table(config, "input.read.config", quote = FALSE, col.names = FALSE, row.names = FALSE)
}

check_sig_hits <- function(o, direct, out_d) {
  setwd(direct)
  # if significant features were found they would be under a file called in-grouping.txt, 
  # if that file exists, it will be added to the list of results along with the p-values associated with them
  if(file.exists("in-grouping.txt")){
  tmp <- read.columns("in-grouping.txt", required.col=c("Feature", "P-value"), text.to.search="", sep="\t", skip=0,
                      fill=TRUE, blank.lines.skip=TRUE, comment.char="", allowEscapes=FALSE)
  o <- rbind(o, tmp)
  }
  #resets the directory to prevent having multiple maaslin_output directories in one maaslin_output directory
  setwd(out_d)
  return(o)
}

sub_maaslin_input <- function(start_subset, stop_subset) {
  maas <- input[,1:2]
  maas <- cbind(maas, input[,start_subset:stop_subset])
  write.table(maas, "in.txt", quote = FALSE, col.names = FALSE, row.names = FALSE, sep="\t")
  make_config(maas)
}


