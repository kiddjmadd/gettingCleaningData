# README.md
## this file provides a high level description of the project. For details, see the "Project.rmd" file also in this directory.
## first step is to merge the training and test datasets.
### structures are same, so I'll just add a column to keep track of test or training datum origin

## second step is to extract just the measurements that are mean & standard deviation.
### I'll do this with regex since the names for the columns of interest include "mean" or "std".

## third step is to use descriptive names for each activity
### For this I'll just use the activities from the activity_labels.txt document.

## fourth step is to appropriately label the data set with descriptive activity names
### I guess I'll add a column for this and include the factor data for each row.

## fifth step is to create a second tidy dataset with average for each activity and each subject.
### for this, I'll use the aggregate function and then perform a "write.csv" to get the file out.
