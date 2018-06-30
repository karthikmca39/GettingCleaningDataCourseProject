#
test <- function() {
    
    # Remove objects from the workspace and garbage collect. Not sure if this is necessary.
    # I read that having unused objects impacts performance, since R stores objects in 
    # memory. Anyways, moving on!
    rm(list = ls())
    gc()
    
    #
    setwd("~/Desktop/datasciencecoursera/Getting and Cleaning Data")
    
    #
    library(tidyverse)
    
    #
    dataset_root_dir <- "UCI HAR Dataset"
    
    #
    activity_labels_file <- "activity_labels.txt"
    features_file <- "features.txt"
    
    #
    training_dir <- "train"
    testing_dir <- "test"
    
    #
    training_subject_file <- "subject_train.txt"
    training_Y_file <- "y_train.txt"
    training_X_file <- "X_train.txt"
    
    #
    testing_subject_file <- "subject_test.txt"
    testing_Y_file <- "y_test.txt"
    testing_X_file <- "X_test.txt"
    
    # Read in the activity labels and features. They are initially read in as factors.
    activity_labels <- read.delim(file = paste(dataset_root_dir, activity_labels_file, sep = "/"), header = FALSE)
    features <- read.delim(file = paste(dataset_root_dir, features_file, sep = "/"), header = FALSE)
    
    # Read in the training data for X and Y. Also read in as factors.
    #train_subject <- read.delim(file = paste(dataset_root_dir, training_dir, training_subject_file, sep = "/"), header = FALSE)
    #train_Y <- read.delim(file = paste(dataset_root_dir, training_dir, training_Y_file, sep = "/"), header = FALSE)
    #train_X <- read.delim(file = paste(dataset_root_dir, training_dir, training_X_file, sep = "/"), header = FALSE)
    
    # Read in the testing data for X and Y. Also read in as factors.
    # test_Y interestingly reads as a data frame, which is really convenient.
    test_subjects <- read.delim(file = paste(dataset_root_dir, testing_dir, testing_subject_file, sep = "/"), header = FALSE)
    test_ydata <- read.delim(file = paste(dataset_root_dir, testing_dir, testing_Y_file, sep = "/"), header = FALSE)
    test_xdata <- read.delim(file = paste(dataset_root_dir, testing_dir, testing_X_file, sep = "/"), header = FALSE)
    
    # Clean the activity labels. They should remain a factor, because they are categorical.
    cleaned_activity_labels <- clean_activity_labels(activity_labels)
    rm(activity_labels)
    
    # Clean the features. They should be a vector of characters, not factors.
    cleaned_features <- clean_features(features)
    rm(features)
    
    # Call the tidy_dataset function, which tidies the train / test data set.
    test_data1 <- tidy_dataset(test_subjects, cleaned_activity_labels, cleaned_features, test_ydata, test_xdata)
    test_data2 <- tidy_dataset(test_subjects, cleaned_activity_labels, cleaned_features, test_ydata, test_xdata)
    
    # Merge the tidied testing and training dataset into one. They should have the same column names.
    # Use rbind to merge the testing and training dataset. Step 1 done, woo!
    merged_dataset <- rbind(test_data1, test_data2)
    
    #

}

# This function generates a tidied data frame given the vector of subjects (N rows),
# the activity labels, the vector features (561 long), the vector of "correct" activities (N rows),
# and the vector of feature measurements (N rows, 1 very long character vector that should be 561 measurements).
tidy_dataset <- function(subjects, activity_labels, features, ydata, xdata) {
    
    # Subject is imported as a data frame already, which is nice. We'll start with that.
    # Just add a helpful column name and we're done!
    names(subjects) <- "SUBJECT"
    
    # Next is the activity column. 
    # Replace the integer vector with a data frame, containing a character
    # vector that coincides with the activity factors.
    cleaned_ydata <- convert_activity_factors(ydata, activity_labels)
    
    # Simply rename the column of the y-dataset to something helpful.
    names(cleaned_ydata) <- "ACTIVITY"
    
    # Finally is the giant data frame of 561xN data frame.
    # Each "row" in the X data contains 561 values, separated by whitespace.
    # The data frame contains N rows (depending on whether we throw in the testing data or training data).
    split_xdata <- lapply(xdata[,], clean_xdata)
    
    # Convert the list of numeric vectors into a data frame.
    # Rows corresponds to one particular set of measurements. 
    # Columns correspond to the particular feature. 561 features. 
    cleaned_xdata <- data.frame(matrix(unlist(split_xdata), nrow = length(split_xdata), byrow = TRUE))
    
    # Set the column names of the features to be the character vector of features.
    # Should be 561 cleaned features, corresponds to 561 columns from the data frame above.
    names(cleaned_xdata) <- features
    
    # Column-bind the three data frames, starting with SUBJECT, followed by ACTIVITY, followed by features.
    # They all should have the same column length, so cbind just sticks them all together!
    # Return this.
    cbind(subjects, cleaned_ydata, cleaned_xdata)
}

# This function cleans the activity labels (mainly just removes the leading integers).
clean_activity_labels <- function(activity_labels) {
    
    # Simply removes the first three characters from each of the factors. For example:
    # "6 LAYING" -> "LAYING" -> returns(LAYING)
    as.factor(sapply(activity_labels, function(x) {substring(x, 3)}))
    
}

# This function cleans the features, which will make up (most of) the columns of our tidy data set.
clean_features <- function(features) {
    
    # Clean the features of the dataset, retrieved from the features file.
    # Simply splits the element of each feature by whitespace, then returns the second element.
    # Example: 1 tBodyAcc-mean()-X -> "1", "tBodyAcc-mean()-X" -> returns("tBodyAcc-mean()-X")
    sapply(features$V1, function(x) {strsplit(as.character(x), " ")[[1]][2]})
}

# This function converts the N rows of character vectors into N rows x 561 columns of measurements.
# xdata should have been saved as a CSV file but whatever. Returns a list of numeric vectors.
clean_xdata <- function(xdata) {
    
    # Remove leading and trailing whitespace. Convert to character to be able to split by whitespace.
    # Split the long character string by whitespace (there's one or two, so I used regex).
    # Convert the now-split values from character to numeric. Repeat for each row in xdata (used lapply).
    as.numeric(strsplit(trimws(as.character(xdata)), "\\s+")[[1]])
    
}

# This function replaces the integer vector of N-row of activities that coincide to the 561 values of xdata.
# Instead of integers, we're going to replace them with the more descriptive activity_labels.
convert_activity_factors <- function(ydata, activity_labels) {
    
    # Simply replace the integer with its corresponding activity label (1 -> WALKING, etc).
    # Save as a data frame that should be N rows long.
    as.data.frame(lapply(ydata, function(x) {activity_labels[x]}))
    
}