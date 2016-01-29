# Getting & Cleaning Data Course Project
# run_analysis.R

# read in all three training set files
trainData <- read.table("./project/train/X_train.txt")
trainLabels <- read.table("./project/train/y_train.txt")
trainSubjects <- read.table("./project/train/subject_train.txt")

# join them, with Subject as first column
allTrain <- cbind(trainSubjects, trainLabels)
allTrain <- cbind(allTrain, trainData)
names(allTrain)[1:2] <- c("Subject","Activity")

# then do the same cbinds for the test set
# and then rbind them all together?
testData <- read.table("./project/test/X_test.txt")
testLabels <- read.table("./project/test/y_test.txt")
testSubjects <- read.table("./project/test/subject_test.txt")

# join them, with Subject as first column
allTest <- cbind(testSubjects, testLabels)
allTest <- cbind(allTest, testData)
names(allTest)[1:2] <- c("Subject","Activity")

# bind test and train together
allData <- rbind(allTrain,allTest)

# now want to rename the remaining columns
# based on the features.txt contents
features <- read.table("./project/features.txt", stringsAsFactors = FALSE)
names(allData)[3:563] <- features$V2

## then modify the activity column to use the strings rather than the numeric code



