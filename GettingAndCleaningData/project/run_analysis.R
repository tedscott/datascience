# Getting & Cleaning Data Course Project
# run_analysis.R
#
## This script reads in the data for the Human Activity data set that can be found at 
## http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

# load dplyr package
library(dplyr)

# read in all three training set files
trainData <- read.table("./train/X_train.txt")
trainLabels <- read.table("./train/y_train.txt")
trainSubjects <- read.table("./train/subject_train.txt")

# join them, with Subject as first column, Activity 2nd
allTrain <- cbind(trainSubjects, trainLabels)
allTrain <- cbind(allTrain, trainData)
names(allTrain)[1:2] <- c("Subject","Activity")

# then do the same cbinds for the test set
# and then rbind them all together?
testData <- read.table("./test/X_test.txt")
testLabels <- read.table("./test/y_test.txt")
testSubjects <- read.table("./test/subject_test.txt")

# join them, as with Training set above
allTest <- cbind(testSubjects, testLabels)
allTest <- cbind(allTest, testData)
names(allTest)[1:2] <- c("Subject","Activity")

# bind test and train together
allData <- rbind(allTrain,allTest)

# now want to rename the remaining columns of the dataset
# based on the features.txt contents in its second column
features <- read.table("./features.txt", stringsAsFactors = FALSE)
names(allData)[3:563] <- features$V2

# extract mean and std columns from features list 
# and then add on subject & activity
# to reduce to these columns from allData
justMeanStd <- grep("mean|std", features$V2, value=T)
keepCols <- c("Subject","Activity",justMeanStd)
reducedData <- allData[keepCols]

# now group by Subject and Activity, and calc mean for each column with summarise_each
reducedData <- reducedData %>% group_by(Subject, Activity) %>% 
  summarise_each(funs(mean))

# then modify the activity column to use the strings in activity_labels.txt
# rather than the numeric code

# read it in
activityLabels <- read.table("./activity_labels.txt", stringsAsFactors = FALSE)

# turn Activity into a factor variable and then change the levels to the strings
reducedData$Activity <- as.factor(reducedData$Activity)
levels(reducedData$Activity) <- activityLabels$V2

# finally, write it out
write.table(reducedData, file = "./humanActivity.txt", row.names = FALSE, col.names = TRUE)

# clean up intermediate data frames
rm(list=c("trainData","trainLabels","trainSubjects","testData","testLabels",
          "testSubjects","allData","allTest","allTrain","features",
          "activityLabels", "justMeanStd","keepCols","reducedData"))
