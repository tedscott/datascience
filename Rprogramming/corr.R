corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations
  ## NOTE: Do not round the result!
  
  # use complete function to get a df of id and complete cases
  df <- complete(directory)
  
  #subset it to those rows where nobs meets or exceeds threshold
  df_subset <- df[which(df[ ,"nobs"] >= threshold), ]
  
  # get all the files in the directory
  allFiles <- list.files(directory, full.names = TRUE)
  
  # now compute correlations between sulfate and nitrate
  # in those files that had completed cases that met the threshold
  
  # create empty numeric vector
  vect <- vector(mode="numeric")#, length=nrow(df_subset))
  j <- 1 # counter
  
  # read in each file in the subset by id
  # and fill a vector with the correlations
  for(i in df_subset$id) {
    dfTmp <- read.csv(allFiles[i])
    tmp <- cor(dfTmp$nitrate,dfTmp$sulfate, use="pairwise.complete.obs")
    if(!is.na(tmp)) {
      vect[j] <- tmp
      j <- j+1
    }
  }
  
  # return value is the vector of correlations
  vect
  
}