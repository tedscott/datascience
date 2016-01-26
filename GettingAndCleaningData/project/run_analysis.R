# Getting & Cleaning Data Course Project
# run_analysis.R

# read in all three training set files
trainData <- read.table("./project/train/X_train.txt")
trainLabels <- read.table("./project/train/y_train.txt")
trainSubjects <- read.table("./project/train/subject_train.txt")

# join them, with Subject as first column
foo <- cbind(trainSubjects, trainLabels)
foo <- cbind(foo, trainData)
names(foo)[1:2] <- c("Subject","Activity")

# now want to rename the remaining columns
# based on the features.txt contents?

# then do the same cbinds for the test set
# and then rbind them all together?
