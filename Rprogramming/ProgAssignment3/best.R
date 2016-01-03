best <- function(state, outcome) {
  ## Read outcome data, change "Not Available" to NA
  outcomes <- read.csv("outcome-of-care-measures.csv", na.strings = "Not Available", stringsAsFactors=FALSE) 
  # create vector of valid outcomes
  validOutcomes <- c("heart attack", "pneumonia", "heart failure")
  
  ## Check that state and outcome args are valid
  if (!(state %in% outcomes$State)) {stop("invalid state")}
  else if (!(outcome %in% validOutcomes)) {stop("invalid outcome")}
  
  ## Return hospital name in that state with lowest 30-day death
  ## rate
  
  # heart attack outcome
  if (outcome == "heart attack") {
    
    # subset to the two columns we need, only rows with no NAs
    resultSet <- subset(outcomes, outcomes$State == state, select = c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack))
    good <- complete.cases(resultSet)
    resultSet <- resultSet[good, ]
    
    # now sort the results, first ascending by outcome, then hospital name
    sortedResults <- resultSet[with(resultSet, order(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Attack, Hospital.Name)), ]
    
  }
  else if (outcome == "pneumonia") {
    # subset to the two columns we need, only rows with no NAs
    resultSet <- subset(outcomes, outcomes$State == state, select = c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia))
    good <- complete.cases(resultSet)
    resultSet <- resultSet[good, ]
    
    # now sort the results, first ascending by outcome, then hospital name
    sortedResults <- resultSet[with(resultSet, order(Hospital.30.Day.Death..Mortality..Rates.from.Pneumonia, Hospital.Name)), ]
  }
  else if (outcome == "heart failure") {
    # subset to the two columns we need, only rows with no NAs
    resultSet <- subset(outcomes, outcomes$State == state, select = c(Hospital.Name, Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure))
    good <- complete.cases(resultSet)
    resultSet <- resultSet[good, ]
    
    # now sort the results, first ascending by outcome, then hospital name
    sortedResults <- resultSet[with(resultSet, order(Hospital.30.Day.Death..Mortality..Rates.from.Heart.Failure, Hospital.Name)), ]
  }
  
  # return best hospital
  #head(sortedResults)
  sortedResults$Hospital.Name[1]
}