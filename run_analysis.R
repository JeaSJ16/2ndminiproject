#Jea S. Juanillo
#BS in Statistics
#CMSC197
#Second Mini Project(run_analysis)

#Set the working directory
setwd("D:/Users/Personal Computer/Desktop/CMSC-197/specdata")
#unzip the file
unzip(zipfile="UCI HAR Dataset.zip", exdir=getwd())
Files<-list.files("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", pattern=".txt", full.names=TRUE, all.files=TRUE)
#Library 
install.packages("plyr")
library(plyr)
library(tidyr)
library(dplyr)

#Merge the training and the test sets to create one data set
#test
test_actdata  <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "test" , "Y_test.txt" ),header = FALSE)
test_subdata  <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "test" , "subject_test.txt"),header = FALSE)
test_featdata  <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "test" , "X_test.txt" ),header = FALSE)

#train
train_actdata <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "train", "Y_train.txt"),header = FALSE)
train_subdata <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "train", "subject_train.txt"),header = FALSE)
train_featdata <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "train", "X_train.txt"),header = FALSE)


activity<- rbind(test_actdata, train_actdata)
subject <- rbind(test_subdata, train_subdata)
features<- rbind(test_featdata, train_featdata)

feat_data <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "features.txt"),head=FALSE)
names(subject)<-c("subject")
names(activity)<- c("activity")
names(features)<- feat_data$V2


sub_act_data <- cbind(subject, activity)
Data <- cbind(features, sub_act_data)


# Extracts only the measurements on the mean and standard deviation for each measurement
filtered_data<-feat_data$V2[grep("mean\\(\\)|std\\(\\)", feat_data$V2)]
fil_data_char<-c(as.character(filtered_data), "subject", "activity" )
Data<-subset(Data,select=fil_data_char)


#Uses descriptive activity names to name the activities in the dataset
act_label <- read.table(file.path("D:/Users/Personal Computer/Desktop/CMSC-197/UCI HAR Dataset", "activity_labels.txt"),header = FALSE)

Data$activity <- as.character(Data$activity)
for (i in 1:6){
  Data$activity[Data$activity == i] <- as.character(act_label[i,2])
              }
Data$activity <- as.factor(Data$activity)
head(Data$activity,30)

#Appropriately labels the data set with descriptive variable names
names(Data)<-gsub("^t", "time", names(Data))
names(Data)<-gsub("^f", "frequency", names(Data))
names(Data)<-gsub("Acc", "Accelerometer", names(Data))
names(Data)<-gsub("Gyro", "Gyroscope", names(Data))
names(Data)<-gsub("Mag", "Magnitude", names(Data))
names(Data)<-gsub("BodyBody", "Body", names(Data)) 


#From the data set in step 4, create a second, independent tidy data set with the average of each variable on each activity and each subject
tidy_data <- tbl_df(Data) %>%
  group_by('subject', 'activity') %>%
  summarise_each(funs(mean)) %>%
  gather(measurement, mean, -activity, -subject)

# Save the data into the file
write.table(tidy_data, file="tidy_data.txt", row.name=FALSE)
