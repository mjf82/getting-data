library(dplyr)

setwd("~/Documents/Coursera Data Science/Getting Data")

# Get list with features
featureFile <- "UCI HAR Dataset//features.txt"
dfFeatures <- read.table(featureFile, stringsAsFactors=FALSE)

# Get activity labels
activFile <- "UCI HAR Dataset//activity_labels.txt"
activities <- read.table(activFile, col.names=c("activity", "activityDesc"))

# Set test data files
xTestFile <- "UCI HAR Dataset//test//X_test.txt"
yTestFile <- "UCI HAR Dataset//test//y_test.txt"
subjectsTestFile <- "UCI HAR Dataset//test//subject_test.txt"

# Set training data files
xTrainFile <- "UCI HAR Dataset//train//X_train.txt"
yTrainFile <- "UCI HAR Dataset//train//y_train.txt"
subjectsTrainFile <- "UCI HAR Dataset//train//subject_train.txt"

# Get test data in data frames, combine and reorganize in single data frame
dfXtest <- read.table(xTestFile, stringsAsFactors=FALSE)
dfYtest <- read.table(yTestFile)
subjectsTest <- read.table(subjectsTestFile)
dfXtest["activity"] <- dfYtest
dfXtest["subject"] <- subjectsTest
dfTest <- select(dfXtest, 562, 563, 1:561)

# Get train data in data frames, combine and reorganize in single data frame
dfXtrain <- read.table(xTrainFile, stringsAsFactors=FALSE)
dfYtrain <- read.table(yTrainFile)
subjectsTrain <- read.table(subjectsTrainFile)
dfXtrain["activity"] <- dfYtrain
dfXtrain["subject"] <- subjectsTrain
dfTrain <- select(dfXtrain, 562, 563, 1:561)

# Put test and train data below eachother in single data frame. Set column names to names in feature list
df <- rbind(dfTest, dfTrain)
names(df)[3:563] = dfFeatures[,2]

# Get subset of data, only get mean and std columns by using pattern matching
dfSubset <- cbind(df[,1:2], df[grepl("mean()", names(df), fixed=TRUE) | grepl("std()", names(df), fixed=TRUE)])

# Add column with activity descriptions by merging with activities data frame
dfSubset <- merge(dfSubset, activities, by.x = "activity", by.y="activity") 
dfFinal <- select(dfSubset, 2, 69, 3:68)

# Get independent summary data frame, getting mean data per activity and subject
dfSummary <- select(aggregate(dfFinal, by = list(dfFinal$subject,dfFinal$activityDesc ), FUN=mean, na.rm=TRUE), 1:2, 5:70)
names(dfSummary)[1:2] <- c("subject", "activityDesc")
