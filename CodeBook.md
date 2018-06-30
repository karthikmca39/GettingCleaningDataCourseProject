# Getting and Cleaning Data Course Project CODEBOOK

by Miguell M


## The Methodology

### Step 1: Merges the training and the test sets to create one data set.

For this step, I first read the activity labels, the features list, and the training / testing data from the dataset. It was important to understand where all the seemingly disparate data related to each other, and was probably the most difficult part of the first step.

The activity labels is a vector of 6 factors, where each integer is associated with a particular physical activity.

The features list is a vector of 516 characters, where each character vector refers to a particular parameter measurement of an activity. The features list becomes the "column names" of our giant dataset, along with the subject, and the activity.

The training / testing subject data contains a column of N integers from 1 ~ 30. Each integer corresponds to a particular test subject performing a particular activity. The subject data becomes a "column" of our giant dataset.

The training / testing Y data contains a column of N integers from 1 ~ 6. Each integer corresponds to a particular activity, which is associated with the activity labels factor. The Y data becomes a "column" of our giant dataset.

The training / testing X data is probably the most complicated, and contains a column of N characters. Each character vector is a giant long string of 516 numbers, normalized from [-1, 1], and separated by whitespace. If they were properly split, the X data would be N rows by 516 columns, where each column refers to the features list mentioned above. The X data makes the bulk of our giant dataset.

Seeing where the pieces fit together was proably the most difficult part. After that, it was a straightforward matter of combining the various features, subjects, activities, and X data for both the training and testing data. Finally, I merged the training and testing data together to make one giant data set.

### Step 2: Extract only the measurements on the mean and standard deviation for each measurement.

For this step, I simply isolated all columns that had the words "mean" or "std" as part of their column names. I made sure to check the lowercase of the names, as some column names have "Mean", which would not match "mean" if I hadn't lowercased it prior to the search. The vagueness of this step lead me to take the straightforward approach that I did.

### Step 3: Uses descriptive activity names to name the activities in the data set.

For this step, I simply used "activity_labels.txt" to get the activity names for a given row. I replaced all integers in the y_test.txt / y_train.txt with the associated activity label. I applied this to my merged dataset and named the column "ACTIVITY", so all succeeding datasets have the same column.

### Step 4: Appropriately labels the data set with descriptive variable names.

For this step, I simply used "features.txt" to get the 561 feature names for the X_test.txt / X_train.txt columns. I applied this to my merged dataset, so all succeeding datasets have the same column names for the various measurements. I was hesitant to replace any characters because some column names used characters like commas as part of the column name (for example: fBodyAcc-bandsEnergy()-57,64), and replacing / removing the comma might impact the column names' meaning.

### Step 5: From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

For this step, I first subsetted the filtered dataset such that I isolated all measurements for a given subject performing a given activity. I then used colMeans to get the means of all the measurements. I repeated this process for all subjects, and all activities. The end result is a dataset of 180 rows (30 subjects x 6 activities) and 88 columns (the number of columns with "mean" or "std" in their name).

SUBJECT
ACTIVITY
tBodyAcc-mean()-X
tBodyAcc-mean()-Y
tBodyAcc-mean()-Z
tBodyAcc-std()-X
tBodyAcc-std()-Y
tBodyAcc-std()-Z
tGravityAcc-mean()-X
tGravityAcc-mean()-Y
tGravityAcc-mean()-Z
tGravityAcc-std()-X
tGravityAcc-std()-Y
tGravityAcc-std()-Z
tBodyAccJerk-mean()-X
tBodyAccJerk-mean()-Y
tBodyAccJerk-mean()-Z
tBodyAccJerk-std()-X
tBodyAccJerk-std()-Y
tBodyAccJerk-std()-Z
tBodyGyro-mean()-X
tBodyGyro-mean()-Y
tBodyGyro-mean()-Z
tBodyGyro-std()-X
tBodyGyro-std()-Y
tBodyGyro-std()-Z
tBodyGyroJerk-mean()-X
tBodyGyroJerk-mean()-Y
tBodyGyroJerk-mean()-Z
tBodyGyroJerk-std()-X
tBodyGyroJerk-std()-Y
tBodyGyroJerk-std()-Z
tBodyAccMag-mean()
tBodyAccMag-std()
tGravityAccMag-mean()
tGravityAccMag-std()
tBodyAccJerkMag-mean()
tBodyAccJerkMag-std()
tBodyGyroMag-mean()
tBodyGyroMag-std()
tBodyGyroJerkMag-mean()
tBodyGyroJerkMag-std()
fBodyAcc-mean()-X
fBodyAcc-mean()-Y
fBodyAcc-mean()-Z
fBodyAcc-std()-X
fBodyAcc-std()-Y
fBodyAcc-std()-Z
fBodyAcc-meanFreq()-X
fBodyAcc-meanFreq()-Y
fBodyAcc-meanFreq()-Z
fBodyAccJerk-mean()-X
fBodyAccJerk-mean()-Y
fBodyAccJerk-mean()-Z
fBodyAccJerk-std()-X
fBodyAccJerk-std()-Y
fBodyAccJerk-std()-Z
fBodyAccJerk-meanFreq()-X
fBodyAccJerk-meanFreq()-Y
fBodyAccJerk-meanFreq()-Z
fBodyGyro-mean()-X
fBodyGyro-mean()-Y
fBodyGyro-mean()-Z
fBodyGyro-std()-X
fBodyGyro-std()-Y
fBodyGyro-std()-Z
fBodyGyro-meanFreq()-X
fBodyGyro-meanFreq()-Y
fBodyGyro-meanFreq()-Z
fBodyAccMag-mean()
fBodyAccMag-std()
fBodyAccMag-meanFreq()
fBodyBodyAccJerkMag-mean()
fBodyBodyAccJerkMag-std()
fBodyBodyAccJerkMag-meanFreq()
fBodyBodyGyroMag-mean()
fBodyBodyGyroMag-std()
fBodyBodyGyroMag-meanFreq()
fBodyBodyGyroJerkMag-mean()
fBodyBodyGyroJerkMag-std()
fBodyBodyGyroJerkMag-meanFreq()
angle(tBodyAccMean,gravity)
angle(tBodyAccJerkMean),gravityMean)
angle(tBodyGyroMean,gravityMean)
angle(tBodyGyroJerkMean,gravityMean)
angle(X,gravityMean)
angle(Y,gravityMean)
angle(Z,gravityMean)