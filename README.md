# Cousera - Getting and Cleaning Data - Course Project

This repository contains the data, code and documentation for the Coursera course "Getting and Cleaning Data".

The dataset included has been downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## Files

The script works on the assumption that all the data is present on the working directory, uncompressed and with the original names.

The file "CodeBook.md" describes the variables, data and transformations performed on the original data set to clean it up.

The script "run_analysis.R" performs the following steps on the original data:

1. Merges the training and the test sets to create one data set.
2. Extracts only the measurements on the mean and standard deviation for each measurement. 
3. Uses descriptive activity names to name the activities in the data set
4. Appropriately labels the data set with descriptive variable names. 
5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

The final output of the last step is called "tidyData.txt" and is also present on this repository.