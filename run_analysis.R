
#get the complete set of data
features <- read.table("./UCI HAR Dataset/features.txt")

##test set
testSet <- read.table("./UCI HAR Dataset/test/X_test.txt", col.names=features[,2])
testLabels <- read.table("./UCI HAR Dataset/test/y_test.txt", col.names = c("activity"))

test <- cbind(testLabels, testSet);

#training set
trainingSet <- read.table("./UCI HAR Dataset/train/X_train.txt", col.names=features[,2])
traininLabels <- read.table("./UCI HAR Dataset/train/y_train.txt", col.names = c("activity"))

training <- cbind(traininLabels, trainingSet)

#combine them and label activity

labels <- read.table("./UCI HAR Dataset/activity_labels.txt")
completeSet <- rbind(test, training)
completeSet <- completeSet[, grepl("(activity)|(std)|(mean)|(STD)|(MEAN)", names(completeSet))]
completeSet$activity <- labels[match(completeSet$activity, labels$V1), 2]

testSubject <- read.table("./UCI HAR Dataset/test/subject_test.txt", col.names = c('subject'))
trainSubject <- read.table("./UCI HAR Dataset/train/subject_train.txt", col.names = c('subject'))
subject <- rbind(testSubject, trainSubject)

completeSet <- cbind(subject, completeSet)

#tidy set
final <- aggregate(completeSet[,2:81], list(completeSet$subject, completeSet$activity), mean)

write.table(final, file = "./tidy.txt", row.name=FALSE)
