library(reshape2)
library(plyr)

# 
# read the train data
train_data <- read.table("dataset/train/X_train.txt")
train_subject <- read.table("dataset/train/subject_train.txt")
train_activity <- read.table("dataset/train/y_train.txt")

#
# read the test data
test_subject <- read.table("dataset/test/subject_test.txt")
test_data <- read.table("dataset/test/X_test.txt")
test_activity <- read.table("dataset/test/y_test.txt")

#
# column combine x and y of train data to become train_activity 
train_data_activity <- cbind(train_data, train_activity)

# column combine of train_activity and subject
train_data_activity_subject <- cbind(train_data_activity, train_subject)

# column combine x and y of test data to become test_activity
test_data_activity <- cbind(test_data, test_activity)

# column combine test_activity and subject 
test_data_activity_subject <- cbind(test_data_activity, test_subject)

# No.1
# Merge the training and test sets to create one data set
# 
dataset <- rbind(train_data_activity_subject, test_data_activity_subject)

# read features label
feature <- read.table("dataset/features.txt")
# extract second column names and remove parentheses ()
transform_header <- gsub("\\(\\)","",feature$V2)
# transform header names from "-" sign to "_" sign
transform_header <- gsub("-","_",transform_header)

# assign column names to dataset with transform_header, activity, volunteer
colnames(dataset) <- c(transform_header,"activity","volunteer")

# extract the header name index which has name ending with 'mean' or 'std'
meanstdfeature <- grep("mean$|std$", transform_header)

# extract the actual headers
header <- transform_header[meanstdfeature]

# No.2 
# Extracts only the measurements on the mean and standard deviation for each measurement. 
#
# extract data with meansurements of mean or standard deviation and column of activity and volunteer number 
extract <- dataset[,c(header,"activity","volunteer")]

# read activity labels into data frame activty_labels and assign column names
activity_labels <- read.table("dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity","activity_label")

#
# No. 3,4
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
#
# merge the extracts with activity labels with common column name 'activty'
result <- merge(extract,activity_labels, sort=FALSE)


# extract the variable names, take out volunteer, activity, activity_label
varnames <- names(result)[2:19]

# reorganize result dataframe into wide format
#
resultmelt <- melt(result, id=c("volunteer", "activity_label"), measure.vars=varnames)

#
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# find the mean for each variable
avgresult <- dcast(resultmelt, volunteer + activity_label ~ variable, mean)

write.table(avgresult, file="result.txt", row.name=FALSE)
