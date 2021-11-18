
# Supposed that our working directory is where our filw is

# Read activity labels and features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt", col.names = c("classLabels", "activityName"))
features <- read.table("UCI HAR Dataset/features.txt", col.names = c("index", "featureNames"))

featuresWanted <- grep("(mean|std)\\(\\)", features[, featureNames])
measurements <- features[featuresWanted, featureNames]
measurements <- gsub('[()]', '', measurements)

#Load and read train data
train <- read.table("UCI HAR Dataset/train/X_train.txt")
train <- train[, featuresWanted, with = FALSE]
data.table::setnames(train, colnames(train), measurements)

trainActivities <- read.table("UCI HAR Dataset/train/Y_train.txt", col.names = c("Activity"))
trainSubjects <- read.table("UCI HAR Dataset/train/subject_train.txt", col.names = c("SubjectNum"))

train <- cbind(trainSubjects, trainActivities, train)

# Read test data 
test <- read.table("UCI HAR Dataset/test/X_test.txt")
test <- test[, featuresWanted, with = FALSE]
data.table::setnames(test, colnames(test), measurements)

testActivities <- read.table("UCI HAR Dataset/test/Y_test.txt", col.names = c("Activity"))
testSubjects <- read.table("UCI HAR Dataset/test/subject_test.txt", col.names = c("SubjectNum"))

test <- cbind(testSubjects, testActivities, test)

# package::functionname
# Merge train and test datasets 
dt <- rbind(train, test)

# Write the dataset to tidyData.txt 
data.table::fwrite(x = dt, file = "tidyData.txt", quote = FALSE)