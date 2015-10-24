### Accelerometer and Gyroscope field variable names imported from "features.txt"
features<-read.table("UCI HAR Dataset/features.txt")
descriptions<-as.character(features[,2])

### Accelerometer and Gyroscope data from Training and Testing sets imported into R, combined into 
### one ("Combination1"), and field variable definitions imported from above updated here as column names.
TrainX<-read.table("UCI HAR Dataset/train/X_train.txt")
TestX<-read.table("UCI HAR Dataset/test/X_test.txt")
Combination1<-rbind(TrainX,TestX)
names(Combination1) <- c(descriptions)

### The mean and standard deviation is extracted here for each of the 561 field variables/measurements above
### and displayed/printed. This achieves the objectives of Task 2 of the course project.
MeanOfData<-colMeans(Combination1)
StandardDevOfData<-apply(Combination1, 2, sd)
Task2<-rbind(MeanOfData,StandardDevOfData)
print(Task2)

### Activity data from Training and Testing sets combined ("Combination2"); column name renamed to be
### "Activity", and Activity definitions updated for clarity (instead of the ambiguous numbers
### 1 to 6 intially assigned.

TestY<-read.table("UCI HAR Dataset/test/y_test.txt")
TrainY<-read.table("UCI HAR Dataset/train/y_train.txt")
Combination2<-rbind(TestY,TrainY)
names(Combination2)<-c("Activity")

Combination2$Activity[Combination2$Activity==1]<-"WALKING"
Combination2$Activity[Combination2$Activity==2]<-"WALKING UPSTAIRS"
Combination2$Activity[Combination2$Activity==3]<-"WALKING DOWNSTAIRS"
Combination2$Activity[Combination2$Activity==4]<-"SITTING"
Combination2$Activity[Combination2$Activity==5]<-"STANDING"
Combination2$Activity[Combination2$Activity==6]<-"LAYING"

### Volunteer ID data from Training and Testing sets combined (Combination3); column name renamed to be
### "VolunteerID"

TestSubject<-read.table("UCI HAR Dataset/test/subject_test.txt")
TrainSubject<-read.table("UCI HAR Dataset/train/subject_train.txt")
Combination3<-rbind(TestSubject, TrainSubject)
names(Combination3)<-c("VolunteerID")

### All fields from combined Training and Testing sets (Combination 1, 2 and 3) combined to form the complete, 
### unified dataset "CompleteData"
CompleteData<-cbind(Combination3, Combination2, Combination1)

### Mean is extracted from "CompleteData" for each activity and each unique volunteer,
### and summarized data is output as a file in defined working directory called "Task5_FinalData.txt"
SegmentedData<-aggregate(CompleteData[,3:563], list(Activity = CompleteData[,2], VolunteerID = CompleteData[,1]),mean)
write.table(SegmentedData, "Task5_FinalData.txt", sep=" ", row.names = FALSE)



