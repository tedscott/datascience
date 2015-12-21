pollutantmean <- function(directory, pollutant, id = 1:332) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'pollutant' is a character vector of length 1 indicating
  ## the name of the pollutant for which we will calculate the
  ## mean; either "sulfate" or "nitrate".
  
  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  
  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  
  # get all the files in the directory
  allFiles <- list.files(directory, full.names = TRUE)
  
  # create empty data frame
  df <- data.frame()
  
  # loop thru all the ids and build a df with rbind
  for(i in id) {
    df <- rbind(df, read.csv(allFiles[i]))
  }
  
  if(pollutant == "sulfate") {
    mean(df$sulfate, na.rm=TRUE)
  } 
  else if(pollutant == "nitrate") {
    mean(df$nitrate, na.rm=TRUE)    
  } 
  else {
    print("unknown pollutant");print(pollutant);
  }
  
}