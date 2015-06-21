## Here are the data for the project:

## https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip

## You should create one R script called run_analysis.R that does the following. 

## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4. Appropriately labels the data set with descriptive variable names. 

## 5. From the data set in step 4, creates a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.


## Load required libraries
library(plyr);


## 1. Merge the training and the test sets to create one data set

# Read data from files
activityLabels = read.table("./UCI HAR Dataset/activity_labels.txt", header=FALSE);
features = read.table("./UCI HAR Dataset/features.txt", header=FALSE);
subjectTest = read.table("./UCI HAR Dataset/test/subject_test.txt", header=FALSE);
xTest = read.table("./UCI HAR Dataset/test/X_test.txt", header=FALSE);
yTest = read.table("./UCI HAR Dataset/test/y_test.txt", header=FALSE);
subjectTrain = read.table("./UCI HAR Dataset/train/subject_train.txt", header=FALSE);
xTrain = read.table("./UCI HAR Dataset/train/X_train.txt", header=FALSE);
yTrain = read.table("./UCI HAR Dataset/train/y_train.txt", header=FALSE);

# Set column names
colnames(activityLabels) = c("activityID", "activity");
colnames(subjectTest) = c("subjectID");
colnames(subjectTrain) = c("subjectID");
colnames(xTest) = features[,2];
colnames(xTrain) = features[,2];
colnames(yTest) = c("activityID");
colnames(yTrain) = c("activityID");

# Create training and test sets by merging X,Y and Subject DataFrames
trainingData = cbind(yTrain, subjectTrain, xTrain);
testData = cbind(yTest, subjectTest, xTest);

# Create complete data set by combining test and training sets
completeData = rbind(trainingData, testData);


## 2. Extract only the measurements on the mean and standard deviation for each measurement

# Create a auxiliary vector of column names to select the appropriate columns later
auxNames = colnames(completeData);

# Create an auxiliary logical vector to select the columns for the mean and the standard deviation
auxLogical = (grepl("activity..",auxNames) | grepl("subject..",auxNames) | grepl("-mean..",auxNames) 
              & !grepl("-meanFreq..",auxNames) & !grepl("mean..-",auxNames) | grepl("-std..",auxNames) 
              & !grepl("-std()..-",auxNames));

# Subset the desired columns from completeData
meanStdData = completeData[,auxLogical];

# Correct the auxNames vector to include only the column names in meanStdData
auxNames = colnames(meanStdData);


## 3. Use descriptive activity names to name the activities in the data set

# Merge meanStdData and activityLabels sets to include descriptive activity names
meanStdData = merge(meanStdData,activityLabels,by='activityID',all.x=TRUE);

# Correct the auxNames vector to include the new column name
auxNames = colnames(meanStdData);


## 4. Appropriately label the data set with descriptive variable names. 

# Change the names un auxNames to be descriptive names
for (i in 1:length(auxNames))
{
  auxNames[i] = gsub("\\()","",auxNames[i])
  auxNames[i] = gsub("-std$"," StdDev",auxNames[i])
  auxNames[i] = gsub("-mean"," Mean",auxNames[i])
  auxNames[i] = gsub("^(t)","Time",auxNames[i])
  auxNames[i] = gsub("^(f)","Frequency",auxNames[i])
  auxNames[i] = gsub("([Gg]ravity)"," Gravity",auxNames[i])
  auxNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)"," Body",auxNames[i])
  auxNames[i] = gsub("[Gg]yro"," Gyro",auxNames[i])
  auxNames[i] = gsub("[Aa]cc"," Acceleration",auxNames[i])
  auxNames[i] = gsub("[Mm]ag"," Magnitude",auxNames[i])
  auxNames[i] = gsub("[Jj]erk"," Jerk",auxNames[i])
};

# Assign the new names to the set
colnames(meanStdData) = auxNames;


## 4. From the data set in step 4, create a second, independent tidy data set 
##    with the average of each variable for each activity and each subject.

# Create a new table without the activity name column to avoid problems with mean
meanStdDataNoActName = meanStdData[,auxNames!="activity"]

# Get only the mean of each variable for each activity and each subject
finalData = aggregate(meanStdDataNoActName[,names(meanStdDataNoActName) != c('activityID','subjectID')],
                     by=list(activityId=meanStdDataNoActName$activityID,subjectID = meanStdDataNoActName$subjectID),
                     mean);

# Merge the finalData with activity name to include again the names
finalData = merge(finalData,activityLabels,by='activityID',all.x=TRUE);

# Export the finalData set
write.table(finalData, './tidyData.txt',row.names=FALSE);
