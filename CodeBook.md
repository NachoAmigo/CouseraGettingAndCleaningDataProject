# Cousera - Getting and Cleaning Data - Course Project

## Description
This is the code book describing the variables, data and transformations performed on the original data provided for the project of the course "Getting and Cleaning Data" from Coursera.

## Source Data
The original data can be found in: https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Additional information about the data and the variables can be found in: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

## Performed steps

### 1. Merge the training and the test sets to create one data set
Assuming the script is located in the same directory as the original data, the script reads the following files:
- features.txt
- activity_labels.txt
- subject_train.txt
- x_train.txt
- y_train.txt
- subject_test.txt
- x_test.txt
- y_test.txt

Then, the script assigns appropriate column names and merges the tables to create one data set.

## 2. Extract only the measurements on the mean and standard deviation for each measurement
The script creates a logical vector that contains TRUE values for the activity ID, the subject ID, and all the mean and stdev columns and FALSE values for all the others.
With this logical vector the script subsets the table produced in step one to keep only the TRUE columns.

## 3. Use descriptive activity names to name the activities in the data set
The script merges the previous data frame with the table loaded with activity names to include them in the data frame.

## 4. Appropriately label the data set with descriptive variable names
The script uses gsub function to replace the column names with descriptive names.

## 5. From the data set in step 4, create a second, independent tidy data set with the average of each variable for each activity and each subject
Finally the script produces a new data set with only the average values for each activity and subject.