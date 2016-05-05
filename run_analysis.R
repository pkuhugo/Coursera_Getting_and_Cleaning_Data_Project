library(dplyr)
library(reshape2)

#1. download file

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
        fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
        download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
        unzip(filename) 
}

#input all the data
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
x_test <- read.table("./UCI HAR Dataset/test/x_test.txt")
y_test <- read.table("./UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt")
x_train <- read.table("./UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./UCI HAR Dataset/train/y_train.txt")
features <- read.table("./UCI HAR Dataset/features.txt")

#Extracts only the measurements on the mean and standard deviation for each measurement. 
#variable related to mean and std
index1 <- grepl(".*mean.*|.*std.*", features$V2)
#clean up the variable name
features1 <- as.character(features$V2[index1])
features1 = gsub('-mean', 'Mean', features1)
features1 = gsub('-std', 'Std', features1)
features1 <- gsub('[-()]', '', features1)


#extract the data related to both mean and std
x_test1 <- x_test[,index1]
x_train1 <- x_train[,index1]
# rename the data
names(x_test1) <- features1
names(x_train1) <- features1
# rename subject to each volunteer's id
names(subject_test) <- "id"
names(subject_train) <- "id"
# rename to activity label
names(y_test) <- "activity"
names(y_train) <- "activity"
# combine test data
total_test <- cbind(subject_test, y_test, x_test1)
total_train<- cbind(subject_train, y_train, x_train1)
merge_data <- rbind(total_test, total_train)
merge_data <- arrange(merge_data, id, activity)

# replace activity id with activity label
merge_data$activity[as.numeric(merge_data$activity) == 1] <- as.character(activity_labels$V2[1])
merge_data$activity[as.numeric(merge_data$activity) == 2] <- as.character(activity_labels$V2[2])
merge_data$activity[as.numeric(merge_data$activity) == 3] <- as.character(activity_labels$V2[3])
merge_data$activity[as.numeric(merge_data$activity) == 4] <- as.character(activity_labels$V2[4])
merge_data$activity[as.numeric(merge_data$activity) == 5] <- as.character(activity_labels$V2[5])
merge_data$activity[as.numeric(merge_data$activity) == 6] <- as.character(activity_labels$V2[6])

#build the second dataset
merge_melted <- melt(merge_data, id.vars=c("id", "activity"))
merge_grouped <- group_by(merge_melted, id, activity)
merge_sum <- summarise(merge_grouped, mean=mean(value))
write.table(merge_sum, "tidy.txt", row.names = FALSE, quote = FALSE)