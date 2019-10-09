# Load necessary paackages
library(data.table)
library(dplyr)
library(tidyr)


# Download and Unzip the dataset for the course project
fileurl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileurl, destfile = "./data/HAR_Dataset.zip")
unzip(zipfile = "./data/HAR_Dataset.zip", exdir="./data")

# Set working directory to Unzipped HAR_Dataset folder
setwd("./data/UCI HAR Dataset/")

# Read all necessary files and create data frames
# (i) Files in HAR dataset folder
features <- read.table("./features.txt", col.names = c("signal_id", "function"))
activityset <- read.table("./activity_labels.txt", col.names = c("activity_id", "activity"))
# (ii) Files in test subfolder
subject_test <- read.table("./test/subject_test.txt", col.names = "subject_id")
x_test <- read.table("./test/X_test.txt", col.names = features[, 2])
y_test <- read.table("./test/y_test.txt", col.names = "activity_id")
# (iii) Files in train subfolder
subject_train <- read.table("./train/subject_train.txt", col.names = "subject_id")
x_train <- read.table("./train/X_train.txt", col.names = features[, 2])
y_train <- read.table("./train/y_train.txt", col.names = "activity_id")


# QN.1. Merge the training and the test sets to create one data set
subjects <- rbind(subject_train, subject_test)
xtest_and_xtrain <- rbind(x_test, x_train)
ytest_and_ytrain <- rbind(y_test, y_train)
fulldata <- cbind(subjects, ytest_and_ytrain, xtest_and_xtrain)

# QN.2. Extract only the measurements on the mean and standard deviation for each measurement
Dataextract <- select(fulldata, subject_id, activity_id, contains("mean"), contains("std"))

# QN.3. Use descriptive activity names to name the activities in the data set
Dataextract$activity_id <- activityset[Dataextract$activity_id, 2]

# QN. 4. Appropriately label the data set with descriptive variable names
names(Dataextract)
names(Dataextract) <- gsub("subject_id", "subject", names(Dataextract))
names(Dataextract) <- gsub("activity_id", "activity", names(Dataextract))
names(Dataextract) <- gsub("^t", "time", names(Dataextract))
names(Dataextract) <- gsub("tBody", "timebody", names(Dataextract))
names(Dataextract) <- gsub("Acc", "accelerometer", names(Dataextract))
names(Dataextract) <- gsub("Gravity", "gravity", names(Dataextract))
names(Dataextract) <- gsub("Gyro", "gyroscope", names(Dataextract))
names(Dataextract) <- gsub("Mag", "magnitude", names(Dataextract))
names(Dataextract) <- gsub("^f", "frequency", names(Dataextract))
names(Dataextract) <- gsub("Mean", "mean", names(Dataextract))
names(Dataextract) <- gsub("BodyBody", "body", names(Dataextract))
names(Dataextract) <- gsub("Body", "body", names(Dataextract))


# QN. 5.Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
tidydata <- group_by(Dataextract, subject, activity)
tidydata <- summarise_all(tidydata, funs(mean))
write.table(tidydata, "tidydata.txt", row.names = FALSE)






