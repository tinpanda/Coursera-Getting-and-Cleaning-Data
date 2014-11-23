# Dowload and unzip data sets
url <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(url, "data.zip")
unzip("data.zip")

# Read files as tables
# Test and train data sets
test_data <- read.table("./UCI HAR Dataset/test/X_test.txt")
train_data <- read.table("./UCI HAR Dataset/train/X_train.txt")
# Subject ids
test_subjects <- read.table("./UCI HAR Dataset/test/subject_test.txt")
train_subjects <- read.table("./UCI HAR Dataset/train/subject_train.txt")
# Activity ids
test_activity_ids <- read.table("./UCI HAR Dataset/test/y_test.txt")
train_activity_ids <- read.table("./UCI HAR Dataset/train/y_train.txt")
# Features
features <- read.table("./UCI HAR Dataset/features.txt", stringsAsFactor=F)
# Activity labels
activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", stringsAsFactor=F)

# (1) Merge subject and activity ids into test and train data. Then merge data sets.
test_set <- cbind(test_data, test_subjects, test_activity_ids)          # Binds test data
train_set <- cbind(train_data, train_subjects, train_activity_ids)      # Binds train data
data_set <- rbind(test_set, train_set)      # Merges test and train data
# (4) Label data set with variable names
colnames(data_set) <- c(features[,2], "Person_id", "Activity")

# (2) Extract the measurements on the mean and standard deviation for each measurement.
means <- apply(data_set[,1:561], 2, mean)
st_devs <- apply(data_set[,1:561], 2, sd)

# (3) Name activities
data_set$Activity <- factor(data_set$Activity, labels=activity_labels[,2])

# (5) Create the tidy data set
# Could not find any other to get this working, so let's loop over each
# Person-Activity combination and calculate mean of each variable. Then merge
# resulting vectors.
for (i in 1:max(data_set$Person_id))    {
    for (j in levels(data_set$Activity))    {
    temp_data <- subset(data_set, Person_id==i & Activity==j)
    means <- apply(temp_data[1:561], 2, mean)
    means[562] <- i
    means[563] <- j
    if(!exists("tidy_data")) {tidy_data <- means}
    tidy_data <- rbind(tidy_data, means)
    }
}
# Reorder variables
tidy_data <- tidy_data[,c(562, 563, 1:561)]
# Give names for the first two columns
colnames(tidy_data)[1:2] <- c("Person_id", "Activity")
# Transform the data matrix as data frame
tidy_data <- data.frame(tidy_data)
# Write the data as .txt file.
write.table(tidy_data, "tidy_data.txt", row.names=FALSE)
