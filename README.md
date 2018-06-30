# Getting and Cleaning Data Course Project README

by Miguell M


## Introduction

This README will explain the nature of the data cleaning assignment, the purpose of the functions I wrote, and the steps I took to clean and process the dataset.


## The Assignment

The assignment prompt is as follows from the Coursera website:

You should create one R script called run_analysis.R that does the following.

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement.

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive variable names.

5. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.


The review criteria for the assignment is as follows from the Coursera website:

1. The submitted data set is tidy.

2. The Github repo contains the required scripts.

3. GitHub contains a code book that modifies and updates the available codebooks with the data to indicate all the variables and summaries calculated, along with units, and any other relevant information.

4. The README that explains the analysis files is clear and understandable.

5. The work submitted for this project is the work of the student who submitted it.


## The Dataset

The dataset for the assignment is UCI's Human Activity Recognition Using Smartphones Data Set from their Machine Learning Repository. It represents data collected from the accelerometer and gyroscope of a Samsung Galaxy SII as it is worn by test subjects performing a number of typical physical activities (standing, walking, laying, etc).

For more detail on the dataset, go to: http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones


## run_analysis.R

run_analysis.R is the only script I wrote, and has all the functions necessary to finish the assignment. Simply run:

```
main()
```

in the command line after sourcing the script, provided you have unzipped the UCI HAR Dataset directory in the same directory as run_analysis.R. The script will (should) proceed as expected, run through the steps of the assignment, produce a tidied dataset in the form of a CSV file, saved in the same working directory.


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