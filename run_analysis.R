##download the data
if(!file.exists("/Users/katharine/Desktop/coursera R/data")) dir.create("/Users/katharine/Desktop/coursera R/data")
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
download.file(fileUrl, destfile = "/Users/katharine/Desktop/coursera R/data/projectData_getCleanData.zip")

##unzip the data
listZip <- unzip("./data/projectData_getCleanData.zip", exdir = "./data")

##load the data
train.x <- read.table("./data/UCI HAR Dataset/train/X_train.txt")
train.y <- read.table("./data/UCI HAR Dataset/train/y_train.txt")
train.subject <- read.table("./data/UCI HAR Dataset/train/subject_train.txt")
test.x <- read.table("./data/UCI HAR Dataset/test/X_test.txt")
test.y <- read.table("./data/UCI HAR Dataset/test/y_test.txt")
test.subject <- read.table("./data/UCI HAR Dataset/test/subject_test.txt")

##1:merge train and test
traindata <- cbind(train.subject, train.y, train.x)
testdata <- cbind(test.subject, test.y, test.x)
data <- rbind(traindata, testdata)

##2:mean and standard deviation
feature <- read.table("./data/UCI HAR Dataset/features.txt", stringsAsFactors = FALSE)
featureNames <- feature[,2]
index <- grep(("mean\\(\\)|std\\(\\)"), featureNames)
data_final <- data[, c(1, 2, index+2)]
colnames(data_final) <- c("subject", "activity", featureNames[index])

##3:name the activities
activityNames <- read.table("./data/UCI HAR Dataset/activity_labels.txt")
colnames(activityNames) <- c("activity", "activityNames")
library(dplyr)
mer <- merge(activityNames, data_final, by="activity")
data_final <- mutate(mer, activity = activityNames)
data_final <- select(data_final, -activityNames)

##4:label the data
names(data_final) <- gsub("\\()", "", names(data_final))
names(data_final) <- gsub("^t", "time ", names(data_final))
names(data_final) <- gsub("^f", "frequency ", names(data_final))

##5:create a data set with mean
data_grouped <- group_by(data_final, activity, subject)
data_grouped <- summarise_each(data_grouped, list(mean))
write.table(data_grouped, "./data/UCI HAR Dataset/MeanData.txt", row.names = FALSE)
