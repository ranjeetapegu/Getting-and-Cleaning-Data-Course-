# set the working directory
library(reshape2)

filename <- "uci_dataset.zip"
setwd("/Users/ranjeetapegu/Documents/Coursera/R Programming/R Development/Data-cleaning/Getting and Cleaning Data Course Project")
getwd()
#download  file
if (!file.exists(filename)){
fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
download.file(fileURL, filename, method="curl")
}
# Unzip the file
if(!file.exists("UCI HAR Dataset")){
  unzip(filename)
}

library(plyr)
# reading from test_set and  test_lable and subject_tes
testset = read.table("./UCI Har Dataset/test/X_test.txt")
trainset =read.table("./UCI Har Dataset/train/X_train.txt")

# extract the features
Features <- read.table("./UCI HAR Dataset/features.txt")

# Renaming the columns
names(testset)<- Features$V2
names(trainset)<- Features$V2

testlabel = read.table("./UCI HAR Dataset/test/Y_test.txt")
trainlabel = read.table("./UCI HAR Dataset/train/Y_train.txt")
#renaming the column name to activity label
testlabel <- rename(testlabel , c("V1"= "Activity_label"))
trainlabel <- rename(trainlabel,c("V1"="Activity_label") )
testsubject = read.table("./UCI HAR Dataset/test/subject_test.txt")
trainsubject = read.table("./UCI HAR Dataset/train/subject_train.txt")
#renaming the column name to subject 
testsubject <- rename(testsubject,c("V1"="Subject"))
trainsubject <- rename(trainsubject,c("V1"="Subject"))

#combine the data sets
testdata <- cbind(testsubject,testlabel,testset)
traindata <- cbind(trainsubject, trainlabel, trainset)
# for debugging
nrow(testdata)
nrow(traindata)

#1.  Merges the training and the test sets to create one data set.
data <- rbind(testdata, traindata)
#check
nrow(data)
names(data)

#2.Extracts only the measurements on the mean and standard deviation for each measurement.
 fmeanstd <- Features$V2[grep("mean\\(\\)|std\\(\\)", Features$V2)]
 selectedNames<-c("Subject", "Activity_label",as.character(fmeanstd) )

 data2 <- subset(data,select=selectedNames)
 names(data2)
 
 # 3 Uses descriptive activity names to name the activities in the data set
 #reading the activity label list
 activity <- read.table("./UCI HAR Dataset/activity_labels.txt", header = FALSE)
 
activity <- rename(activity,c("V1"="Activity_label", "V2"="Activity"))
 
 Activitydata <- merge(activity,data ,by="Activity_label")
 dim(Activitydata)
 Activitydata <- Activitydata[, c(2:564)]
 head(Activitydata[1,c(1)],40)
 
 #Appropriately labels the data set with descriptive variable names.
 # t is time, Acc is Accelerometer, Gyro is Gyroscope,  f is requency  Mag is  Magnitude,  BodyBody is  Body
 names(Activitydata)
 #gsub() function will be used to replace above string to descriptive string
 names(Activitydata) <- gsub("^t","time",names(Activitydata))
 names(Activitydata) <- gsub("^f","frequency",names(Activitydata))
 names(Activitydata) <- gsub("BodyBody","Body",names(Activitydata))
 names(Activitydata) <- gsub("Gyro","Gyroscope",names(Activitydata))
 names(Activitydata) <- gsub("Mag","Magnitude",names(Activitydata))
 names(Activitydata) <- gsub("Acc","Accelerometer",names(Activitydata))
 names(Activitydata) <- gsub("\\(tB","\\(timeB",names(Activitydata))
 
 
 #5.From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
 library(dplyr)
 TidyData <- aggregate(Activitydata[, 3:563], list(Activitydata$Activity,Activitydata$Subject ), mean)
 library(plyr)
 TidyData <- rename(TidyData,Activity=Group.1, Subject=Group.2)
 nrow(TidyData)
 names(TidyData)
 write.table(TidyData, "tidy.txt", row.names = FALSE, quote = FALSE)
 