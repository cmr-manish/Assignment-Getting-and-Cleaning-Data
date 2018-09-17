# Downloading and unzipping the dataset
if(!file.exists("./project"))
  {dir.create("./project")}
datalink <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(datalink,destfile="./project/Dataset.zip")
unzip(zipfile="./project/Dataset.zip",exdir="./project")

# 1. Merges the training and the test sets to create one data set.
# Reading train tables
x_train <- read.table("./project/UCI HAR Dataset/train/X_train.txt")
y_train <- read.table("./project/UCI HAR Dataset/train/y_train.txt")
subject_train <- read.table("./project/UCI HAR Dataset/train/subject_train.txt")

# Reading test tables
x_test <- read.table("./project/UCI HAR Dataset/test/X_test.txt")
y_test <- read.table("./project/UCI HAR Dataset/test/y_test.txt")
subject_test <- read.table("./project/UCI HAR Dataset/test/subject_test.txt")

features <- read.table('./project/UCI HAR Dataset/features.txt')
activityLabels = read.table('./project/UCI HAR Dataset/activity_labels.txt')

# Setting col names
colnames(x_train) <- features[,2] 
colnames(y_train) <-"activityId"
colnames(subject_train) <- "subjectId"

colnames(x_test) <- features[,2] 
colnames(y_test) <- "activityId"
colnames(subject_test) <- "subjectId"

colnames(activityLabels) <- c('activityId','activityType')

# Merge data in to 1 set
train_merged <- cbind(y_train, subject_train, x_train)
test_merged <- cbind(y_test, subject_test, x_test)
mergeddataset <- rbind(train_merged, test_merged)

# 2. Extracts only the measurements on the mean and standard deviation for each measurement.
colNAME <- colnames(mergeddataset)
# Separate ID, mean and SD for all measurements

ID_mean_sd <- (grepl("activityId" , colNAME) | 
                   grepl("subjectId" , colNAME) | 
                   grepl("mean.." , colNAME) | 
                   grepl("std.." , colNAME))

# Create Subset
meanSD_subset <- mergeddataset[ , ID_mean_sd == TRUE]

# 3. Uses descriptive activity names to name the activities in the data set
descriptiveNames <- merge(meanSD_subset, activityLabels,
                          by='activityId',
                          all.x=TRUE)

# 4. From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
secondtidyset <- aggregate(. ~subjectId + activityId, descriptiveNames, mean)
secondtidyset <- secondtidyset[order(secondtidyset$subjectId, secondtidyset$activityId),]

write.table(secondtidyset, "secondtidyset_Final.txt", row.name=FALSE)

