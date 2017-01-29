if(!file.exists("./project3data")){dir.create("./project3data")}
#create a directory for the data
fileUrl <- "https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
#load the zipped data file
download.file(fileUrl,destfile="./project3data/UCIDataset.zip")
#download the zipped data file
unzip(zipfile="./project3data/UCIDataset.zip",exdir="./project3data")
#unzip the file to the directory that was created
X_test <- read.table("./project3data/UCI HAR dataset/test/X_test.txt")
y_test <- read.table("./project3data/UCI HAR dataset/test/y_test.txt")
subject_test <- read.table("./project3data/UCI HAR dataset/test/subject_test.txt")
#read in the three tables in the test folder
X_train <- read.table("./project3data/UCI HAR dataset/train/X_train.txt")
y_train <- read.table("./project3data/UCI HAR dataset/train/y_train.txt")
subject_train <- read.table("./project3data/UCI HAR dataset/train/subject_train.txt")
#read in the three tables in the train folder
activity_labels <- read.table("./project3data/UCI HAR dataset/activity_labels.txt")
#read in the activity labels table
features <- read.table("./project3data/UCI HAR dataset/features.txt")
#read in the features table
library(plyr)
#load the plyr package
X_data <- rbind(X_train,X_test)
y_data <- rbind(y_train,y_test)
subject_data <- rbind(subject_train,subject_test)
#combine data by rows using rbind() for x, y, and subject
names(subject_data)<- c("subject")
names(y_data)<- c("activity")
names(X_data) <- features$V2
#set names to data (subject = subject, y = activity, x = features) *called the feature table I read in line 19
mergedata <- cbind(subject_data,y_data)
#combine the subject & activity data
alldata <- cbind(X_data, mergedata)
#combine with the feature data
colNames <- colnames(alldata)
#creating a variable for the column names in the merged data file
meanstd <- (grepl("activity" , colNames) | 
                   grepl("subject" , colNames) | 
                   grepl("mean.." , colNames) | 
                   grepl("std.." , colNames) 
)
#creating a variable for column names that have values of activity, subject, mean, or std. use grepl to find values 
newsubset <- alldata[, meanstd == TRUE]
#subset the merged data based on the variable above that only looks at mean and std features
newsubset$activity <- as.character(newsubset$activity)
#change to character class 
newsubset$activity[newsubset$activity == 1] <- "Walking"
newsubset$activity[newsubset$activity == 2] <- "Walking Upstairs"
newsubset$activity[newsubset$activity == 3] <- "Walking Downstairs"
newsubset$activity[newsubset$activity == 4] <- "Sitting"
newsubset$activity[newsubset$activity == 5] <- "Standing"
newsubset$activity[newsubset$activity == 6] <- "Laying"
#replace activity columns to descriptive labels
newsubset$activity <- as.factor(newsubset$activity)
#change class back to vector of integers and character values
names(newsubset) <- gsub("^t", "time", names(newsubset))
names(newsubset) <- gsub("^f", "frequency", names(newsubset))
names(newsubset) <- gsub("Acc", "Accelerometer", names(newsubset))
names(newsubset) <- gsub("Gyro", "Gyroscope", names(newsubset))
names(newsubset) <- gsub("Mag", "Magnitude", names(newsubset))
names(newsubset) <- gsub("Jerk", "JerkSignal", names(newsubset))
names(newsubset) <- gsub("BodyBody", "Body", names(newsubset))
#giving the features more descriptive names - substitute the old name with new name
secondtidydata <- aggregate(. ~subject + activity, newsubset, mean)
#create a second tidy data set with the average for each subject and each activity
secondtidydata <- secondtidydata[order(secondtidydata$subject, secondtidydata$activity),]
#ordering the columns by subject then by activity
write.table(secondtidydata, file = "secondtidydata. txt", row.name = FALSE)
#creating a new table and saving it in a text file
