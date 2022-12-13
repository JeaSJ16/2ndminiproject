# 2ndminiproject
Jea Juanillo
BS in Statistics

After downloading the UCI HAR Dataset.zip file, a directory called "spacdata" was created, and then the run_analysis.R was run.
The script contains the following process:

1. Merging of the training and test sets to create one data set
First is to read and assign a name to each text using the read.table function for the training and test datasets.
Then combine the training and test data for activity, subject, and features using the rbind function, and label properly.
Then combine the subject and activity labelled "sub_act_data."
Read the feature data, then combine everything into one dataset called Data.

2. Extraction of data with mean and standard deviation measurements
To extract the dataset with the mean and standard deviation, use the function grepl.

3. Names the activities in the dataset using descriptive activity names.
Read the activity_labels.txt file first before using the descriptive activity names.
Then create a loop to change the name in the Data.
 
4. Appropriately label the dataset with descriptive variable names.
To appropriately label the dataset, use the function gsub to change each name.
- ^t was changed to time.
- ^f was changed to frequency.
- Acc was changed to Accelerometer.
- Gyro was changed to Gyroscope.
- Mag was changed to Magnitude.
- BodyBody was changed to Body.

5. Create a second, independent tidy dataset with the average of each variable for each activity and each subject.
To create tidy data, use the library (tidyr) and the data function tbl_dt.
Finally, save the dataset using the write.table function.
