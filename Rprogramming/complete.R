complete <- function(directory, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  
  # get all the files in the directory
  allFiles <- list.files(directory, full.names = TRUE)
  
  # create empty data frame
  df <- data.frame()
  
  # read in the files
  # and store in the DF the number of complete cases
  for(i in id) {
    df <- rbind(df, sum(complete.cases(read.csv(allFiles[i]))))
  }
  
  df <- cbind(id, df)
  names(df) <- c("id","nobs")
  df
  
}