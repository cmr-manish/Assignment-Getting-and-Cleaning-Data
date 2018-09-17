For this project, dataset was downloaded from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip. 
Training and test data were merged to create a combined dataset, and then mean and standara deviation was extracted for each measurement. To create the final dataset, these measurements were averaged for each subject and activity.

The R Script run_analysis.R can be used to work with the data set and get the final result. The comments in the script and the code book will help you through the implementation of the steps, which at a high level can be classified as:

1. Checking if the data already exists, and downloading the data if it doesn't exist
2. Reading the data from each file
3. Merging the train and test sets to create one dataset
4. Extract mean and SD from the dataset
5. Create a second data set with average of each variable for each activity and each subject
6. Write the second data set in to a file