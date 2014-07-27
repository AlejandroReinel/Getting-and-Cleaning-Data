# Getting-and-Cleaning-Data
=========================

# Getting and Cleaning Data Project
 
=================
The oringial data was obtained from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip
In this folder you can find detailed information on the oringial variables and where they came from ('features.txt' and 'features_info.txt' from unzipped file).

The r script run_analysis.r was used to create the file tidy_data.txt

run_analysis.r does the folowing

* Merges the training and the test sets to create one data set.
* Extracts only the measurements on the mean and standard deviation for each measurement. 
* Uses descriptive activity names to name the activities in the data set
* Appropriately labels the data set with descriptive variable names. 
* Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 
* Saves the new dataset

The new dataset contains a calulation for the mean of all Standard Deviation and Mean from all original variables. Other variables where excluded.

Variables:

subjet_id (integer): indicates the identification number for each subject
activity_id (character): labes what activity was beaing done when the mesurment was taken

### ALL OF THE OTHER VARIABLES (float): 
#### Contain the mean of orignal Standar Devianton and Means of each mesurment. Column titles are self descriptive;
* acc: Accelerometer 
* gyro: Gyroscope
* Mean: Mean value
* StDev: Standard deviation
* mag: Magnitude
* XYZ: 3-axial signals in the X, Y and Z directions
