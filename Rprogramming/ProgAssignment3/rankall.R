rankall <- function(outcome, num = "best") {
  ## Read outcome data, change "Not Available" to NA
  fullFile <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors=FALSE) 
  # create vector of valid outcomes
  validOutcomes <- c("heart attack", "pneumonia", "heart failure")
  
  ## Check that state and outcome args are valid
  if (!(outcome %in% validOutcomes)) {stop("invalid outcome")}
  
  # reduce data set to columns of interest
  outcomes <- subset(fullFile, select = c(Hospital.Name, State, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
  names(outcomes) <- c("hospital", "state", "heart_attack", "heart_failure", "pneumonia")
  #View(outcomes)
  
  ## For each state, find the hospital of the given rank
  if (outcome == "heart attack") {
    
    # subset to the three columns we need, only rows with no NAs
    resultSet <- subset(outcomes, select = c(hospital, state, heart_attack))
    sortedResults <- resultSet[with(resultSet, order(state, heart_attack, hospital)), ]
    #View(sortedResults)
    if(num=="best") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(1)
    }
    else if(num=="worst") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(n())
    }
    else {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(num)
    }
    
    # return the final DF
    sortedResults
  }
  
  else if (outcome == "heart failure") {
    
    # subset to the three columns we need, only rows with no NAs
    resultSet <- subset(outcomes, select = c(hospital, state, heart_failure))
    sortedResults <- resultSet[with(resultSet, order(state, heart_failure, hospital)), ]
    #View(sortedResults)
    if(num=="best") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(1)
    }
    else if(num=="worst") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(n())
    }
    else {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(num)
    }
    
    # return the final DF
    sortedResults
  }
  else if (outcome == "pneumonia") {
    
    # subset to the three columns we need, only rows with no NAs
    resultSet <- subset(outcomes, select = c(hospital, state, pneumonia))
    sortedResults <- resultSet[with(resultSet, order(state, pneumonia, hospital)), ]
    #View(sortedResults)
    
    if(num=="best") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(1)
    }
    else if(num=="worst") {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(n())
    }
    else {
      sortedResults <- sortedResults %>%
        group_by(state) %>% 
        select(hospital, state) %>%
        slice(num)
    }
    
    # return the final DF
    sortedResults
  }
}