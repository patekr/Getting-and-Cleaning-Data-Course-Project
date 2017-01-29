##CodeBook

###Variables
* X_test, y_test, subject_test - contains three tables in test folder
* X_train, y_train, subject_train - contains three tables in train folder
* activity_labels - contains activity labels data
* features - contains feature labels data
* X_data - contains combined features data (test and train)
* y_data - contains combined activity data (test and train)
* subject_data - contains combined subject data (test and and train)
* mergedata - merged the subject and activity data together
* alldata - merged the subject & activity dataset with feature data
* meanstd - creates a variable that searches for columns with variables that have values of mean or standard deviation
* newsubset - creates a subset of the data only looking at columns subject, activity, and those that include the values of mean or standard deviation
* secondtidydata - new tidy data set with the average for each subject and each activity

###Process
* Create directory for the data
* Download zipped data file
* Unzip data file
* Read in the tables in the test folder
* Read in the tables in the train folder
* Read in the activity labels and features data
* Load the plyr package
* Combine data by rows using rbind() command for x, y, and subject data
* Rename the combined data to something descriptive
* Combine the data by columns using cbind() for subject and activity (y), then with features (x)
* Create variable that counts column names with activity, subject, mean, and standard deviation
* Create subset of data with the variable above^
* Rename activities with descriptive names (e.g. "Walking", "Walking Upstairs", "Walking Downstairs", "Sitting", "Standing", "Laying")
* Rename features with descriptive names (e.g. "time", "frequency", "Accelerometer", "Gyroscope", "Magnitude", "JerkSignal", "Body")
* Aggregate the average of each variable for each activity and each subject in to a new data set
* Write new data set and save as a text file
