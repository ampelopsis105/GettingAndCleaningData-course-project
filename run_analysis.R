#download file and unzip,change work direction into the dataset file
download.file(url="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip",destfile="data.zip")
unzip("data.zip")
setwd("./UCI HAR Dataset")
#Merges the training and the test sets to create one data set.
features <- read.table('features.txt')
test.x <- read.table('./test/X_test.txt',col.names=features[,2])
train.x <- read.table('./train/X_train.txt',col.names=features[,2])
x <- rbind(test.x,train.x)
#Extracts only the measurements on the mean and standard deviation for each measurement.
features <- features[grep('(mean|std)\\(',features[,2]),]
meanAndstd <- x[,features[,1]]
#Uses descriptive activity names to name the activities in the data set
test.y <- read.table('./test/y_test.txt',col.names=c('activity'))
train.y <- read.table('./train/y_train.txt',col.names=c('activity'))
y <- rbind(test.y,train.y)
labels <- read.table("activity_labels.txt")
for (i in 1:nrow(labels)){
  id <- as.numeric(labels[i,1])
  name <- as.character(labels[i,2])
  y[y$activity==id,] <- name
}
#Appropriately labels the data set with descriptive activity names.
x_label <- cbind(y,x)
meanAndstd_lable <- cbind(y,meanAndstd)
#Creates a second, independent tidy data set with the average of each variable\each activity\each subject.
test.subject <- read.table("./test/subject_test.txt",col.names=c('subject'))
train.subject <- read.table("./train/subject_train.txt",col.names=c('subject'))
subject <- rbind(test.subject,train.subject)
average <- aggregate(x,by=list(activity=y[,1],subject=subject[,1]),mean)
# write a text file to submit
write.table(average,file='result.txt',row.names=FALSE)
