# Author: Wilson
# Date  : 2015-10-24
# Description:
# getting and cleaning data - course project
###############################################################################
# 1. Merges the training and the test sets to create one data set.
# 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
# 3. Uses descriptive activity names to name the activities in the data set
# 4. Appropriately labels the data set with descriptive variable names. 
# 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 

#download data from web site
library(httr) 

raw_file <- "./raw.zip"
if(!file.exists(raw_file))
{
    download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",
                  destfile="raw.zip", method="curl")
    unzip ("raw.zip", exdir = "./")
}

# 1. Merges the training and the test sets to create one data set
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt")

x_test <- read.table("./UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")

x_data <- rbind(x_train, x_test)
y_data <- rbind(y_train, y_test)
subject_data <- rbind(subject_train, subject_test)

# 2. Extracts only the measurements on the mean and standard deviation for each 
#    measurement
features <- read.table("./UCI HAR Dataset/features.txt")
mean_and_std <- grep("-(mean|std)\\(\\)", features[, 2])
x_data <- x_data[, mean_and_std]
names(x_data) <- features[mean_and_std, 2]

# 3. Uses descriptive activity names to name the activities in the data set
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
y_data[, 1] <- activity_labels[y_data[, 1], 2]
names(y_data) <- "activity"

# 4. Appropriately labels the data set with descriptive variable names
names(subject_data) <- "subject"
combind_data <- cbind(x_data, y_data, subject_data)

# 5. Creates a second, independent tidy data set with the average of each 
#    variable for each activity and each subject
library(plyr)
average<- ddply(combind_data, .(subject, activity), 
                       function(x) colMeans(x[, 1:66]))
write.table(average, "tidy_dataset.txt", row.name = FALSE)

