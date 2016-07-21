## Getting and Cleaning Data Course

This document describes the variables, the data, and any transformations or work that was performed to clean up the data for the assignment.

About the Data :
For this assignment, the data was taken from one of the most exciting areas in all of data science,wearable computing.
The Data linked to from the course website represent data collected from the accelerometers from the Samsung Galaxy S smartphone. A full description is available at the site where the data was obtained:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

Here are the data for the project:
https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

To know more about the data in question please go through the README.txt in UCI HAR Dataset.
Following the steps to create a more meaningful and tidy dataset.

1. Merges the training and the test sets to create one data set
i. set the working directory and Download the Dataset folder using the url mentioned above. Unzip the file.
ii. Read the following and DataSets using the read.table function , into data.frame
 testlabel = test label (<dir>/test/Y_test.txt)
 testsubject = test subject, ranges from 1 to 30 (<dir>/test/Subject_test.txt)
 trainset = training set (<dir>/train/X_train.txt)
 trainlabel = train label (<dir>/train/Y_test.txt)
 trainsubject = train subject, ranges from 1 to 30 (<dir>/train/Subject_test.txt)
 activity = links the class labels with their activity name.(<dir>/activity_labels.txt)
 feature = List of all features (<dir>/features.txt)
 
 iii. Rename the dataframe using rename function from plyr package
 iv. Merge the test datasets (testsubject,testlabel,testset) using cbind function.
 v. Merge the train datasets (trainsubject, trainlabel, trainset) using cbind function.
 vi. Combine the test and train dataset using rbind function in data.frame called data.
 
 2.  Extracts only the measurements on the mean and standard deviation for each measurement.
 i. Extract the names of columns from the data.frame(feature) with measurements on the mean and standard
 using the grep function in fmeanstd
 ii. subset the data dataframe and get the required fields only.
 
3.  Uses descriptive activity names to name the activities in the data set
i. Merge the activity and data dataframe using merge function on column Activity_label in Activitydata

ii. subset ActivityData to get all the required fields. 

4. Appropriately labels the data set with descriptive variable names.
i. use #gsub() function to replace abbreviation with a proper descriptive name.

 5. Creates a independent tidy data set with the average of each variable for each activity 
 and each subject.
 i. use the dplyr package.
 ii. use an aggregate function to take mean of the fields group by Activity, Subject.


