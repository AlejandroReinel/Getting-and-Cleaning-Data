##########################################################################################################

## Coursera Getting and Cleaning Data Course Project
# run_analysis.R 

## please download and unzip file in working direcrory
## file can be donloaded from 
##  https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

## R script called run_analysis.R does the following. 
## 1. Merges the training and the test sets to create one data set.
## 2. Extracts only the measurements on the mean and standard deviation for each measurement. 
## 3. Uses descriptive activity names to name the activities in the data set
## 4.Appropriately labels the data set with descriptive variable names. 
## 5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject.
##########################################################################################################

## 1. Merge the training and the test sets to create one data set.

## set working directory 
setwd("C:/Users/Alejandro Reinel/Documents/UCI HAR Dataset")

## load gdata
library(gdata)

# Read Metadata
features <- read.table('./features.txt',header=FALSE)
activity_labels <- read.table('./activity_labels.txt',header=FALSE)

## Read Train Data
subject_train <- read.table('./train/subject_train.txt',header=FALSE)
x_train <- read.table('./train/x_train.txt',header=FALSE)
y_train <- read.table('./train/y_train.txt',header=FALSE)

## Read Test Data
subject_test <- read.table('./test/subject_test.txt',header=FALSE)
x_test <- read.table('./test/x_test.txt',header=FALSE)
y_test <- read.table('./test/y_test.txt',header=FALSE)

## Set correct column names
colnames(activity_labels) <- c('activity_Id','activity_type')
colnames(subject_train) <- "subject_Id"
colnames(x_train) <- features[,2] 
colnames(y_train) <- "activity_Id"
colnames(subject_test)  <- "subject_Id"
colnames(x_test) <- features[,2] 
colnames(y_test) <- "activity_Id"

## Merge yTrain, subjectTrain, and xTrain to create train database
train_db <- cbind(subject_train,y_train,x_train)

## Merge xTest, yTest and subjectTest to create test database
test_db <- cbind(subject_test,y_test,x_test)

## Merge train and test to create a final data set
database <- rbind(train_db,test_db)

## Clear workspace to save memory
keep(database,activity_labels,sure=TRUE)

## 2. Extract only the measurements on the mean and standard deviation for each measurement. 

## Create a selection Vector diferentiates desiered mesurments by TRUE or FALSE, and remove unwanted
colNames <- colnames(database)
selection_char<-(grepl("mean()",colNames)|grepl("std()",colNames)|grepl("subject",colNames)|grepl("activity",colNames))
database <- database[selection_char==TRUE]

## Remove Freq variables from dataset
colNames <- colnames(database)
selection_char<-!grepl("Freq",colNames)
database <- database[selection_char==TRUE]

## 3. Use descriptive activity names to name the activities in the data set

## Replace activiy_id numbers with character labels
database <- merge(database,activity_labels,by='activity_Id',all.x=TRUE)
database[,1]<-database[,69]

## 4. Appropriately label the data set with descriptive activity names. 

## Create a vector containing colnames to clean up
colNames <- colnames(database)

## Clean-up colnames names
for (i in 1:length(colNames)) 
{
  colNames[i] = gsub("\\()","",colNames[i])
  colNames[i] = gsub("^(t)","Time_",colNames[i])
  colNames[i] = gsub("^(f)","Freq_",colNames[i])
  colNames[i] = gsub("([Gg]ravity)","Gravity_",colNames[i])
  colNames[i] = gsub("([Bb]ody[Bb]ody|[Bb]ody)","Body_",colNames[i])
  colNames[i] = gsub("[Gg]yro","Gyro_",colNames[i])
  colNames[i] = gsub("[Aa]cc","Acc_",colNames[i])
  colNames[i] = gsub("[Jj]erk","Jerk_",colNames[i])
  colNames[i] = gsub("[Mm]ag","Mag_",colNames[i])
  colNames[i] = gsub("-std","StdDev",colNames[i])
  colNames[i] = gsub("-mean","Mean",colNames[i])
}


## Replace with new colnames
colnames(database) = colNames

## 5. Create a second, independent tidy data set with the average of each variable for each activity and each subject. 

## Summarize data to include mean by subjet and activity
tidy_data<-aggregate(.~subject_Id+activity_Id, data=database, mean,na.rm=TRUE)
tidy_data$activity_type<-NULL
##Save the new dataset 
write.csv(tidy_data, './tidyData.csv',row.names = FALSE)