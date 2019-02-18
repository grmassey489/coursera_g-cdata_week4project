library(reshape2)

filename <- "getdata_dataset.zip"

## Download and unzip the dataset:
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip "
  download.file(fileURL, filename, method="curl")
}  
if (!file.exists("UCI HAR Dataset")) { 
  unzip(filename) 
}

# Load activity labels + features
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activityLabels[,2] <- as.character(activityLabels[,2])
features <- read.table("UCI HAR Dataset/features.txt")
features[,2] <- as.character(features[,2])

# build keeper table
keepers <- grep(".*mean.*|.*std.*", features[,2])
keepers.names <- features[keepers,2]
keepers.names = gsub('-mean', 'Mean', keepers.names)
keepers.names = gsub('-std', 'Std', keepers.names)
keepers.names <- gsub('[-()]', '', keepers.names)

#load data

movement <- read.table("UCI HAR Dataset/train/X_train.txt")[keepers]
moveactivities <- read.table("UCI HAR Dataset/train/Y_train.txt")
movesubjects <- read.table("UCI HAR Dataset/train/subject_train.txt")
movement <- cbind(movesubjects, moveactivities, movement)

test <- read.table("UCI HAR Dataset/test/X_test.txt")[keepers]
testactivities <- read.table("UCI HAR Dataset/test/Y_test.txt")
testsubjects <- read.table("UCI HAR Dataset/test/subject_test.txt")
test <- cbind(testsubjects, testactivities, test)

#merge datasets + label

allData <- rbind(movement, test)
colnames(allData) <- c("subject", "activity", keepers.names)

#convert activities & subjects to factors

allData$activity <- factor(allData$activity, levels = activityLabels[,1], labels = activityLabels [,2])
allData$subject <- as.factor(allData$subject)

allData.melted <- melt(allData, id = c("subject", "activity"))
allData.mean <- dcast(allData.melted, subject + activity ~ variable, mean)

write.table(allData.mean, "tidy.txt", row.names = FALSE, quote = FALSE)