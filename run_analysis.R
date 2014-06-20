# Project



#Reading the data

#Reading and binding the X_test and Y_test
teste <- read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/test/X_test.txt")
label.teste<-read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/test/Y_test.txt")
names(label.teste)="subject"
indica<-rep(1,length(teste$V1))  #this variable indicates if the register comes from train or test (but it's not needed in this project)
testeU<-cbind(label.teste,indica,teste)

#Reading and binding the X_train and Y_train
treino <- read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/train/X_train.txt")
label.treino<-read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/train/Y_train.txt")
names(label.treino)="subject"
indica<-rep(2,length(treino$V1)) #this variable indicates if the register comes from train or test (but it's not needed in this project)
treinoU<-cbind(label.treino,indica,treino)

base<-rbind(treinoU,testeU)

#reading the activity labels
atividade<-read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/activity_labels.txt",col.names=c("subject","activity"))

#merging the activity dataset with the train plus test dataset to specify the names of the activities

O=merge(atividade,base,by="subject")


#reading the features data set to label the merged data set correctly

readfeat<-read.table("~/Desktop/Doutorado/Data science specialization/UCI HAR Dataset/features.txt")
features<-as.character(readfeat[,2])

names(O)<-c("subject","activity","indica",features)

#selecting only the mean and std features to get the final data set called "basefinal"

features2=c("mean()","mean()","mean()",features)
padrao=c("mean|std()")
X=O[grep(padrao, features2)]
padrao2=c("meanFreq()")
basefinal=X[-c(1,3,grep(padrao2, names(X),fixed=T))]




#Making the tidy data set

attach(basefinal)
tidied <-aggregate(basefinal, by=list(activity), 
                    FUN=mean, na.rm=TRUE)
detach(basefinal)

tidied<-tidied[-2]

#Making the name of the variables very descriptive
namestochange<-names(basefinal)

#time body acceleration
namestochange<-gsub("tBodyAcc", "time_body_acceleration_", namestochange, ignore.case = FALSE, perl = FALSE,
     fixed = TRUE, useBytes = FALSE)

#time gravity acceleration
namestochange<-gsub("tGravityAcc", "time_gravity_acceleration_", namestochange, ignore.case = FALSE, perl = FALSE,
     fixed = TRUE, useBytes = FALSE)

#time body gyroscopic

namestochange<-gsub("tBodyGyro", "time_body_gyroscopic_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

#frequency body acceleration

namestochange<-gsub("fBodyAcc", "frequency_body_acceleration_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

#frequency body gyroscopic

namestochange<-gsub("fBodyGyro", "frequency_body_gyroscopic_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

#correcting the double word "Body" "BodyBody" and its derivates
namestochange<-gsub("fBodyBodyAcc", "frequency_body_acceleration_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)
namestochange<-gsub("fBodyBodyGyro", "frequency_body_gyroscopic", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)


#correcting mean and std

namestochange<-gsub("_-mean()-", "_mean_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

namestochange<-gsub("-mean()-", "_mean_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

namestochange<-gsub("-mean()", "_mean", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)


namestochange<-gsub("_-std()-", "_std_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

namestochange<-gsub("-std()-", "_std_", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

namestochange<-gsub("-std()", "_std", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

namestochange<-gsub("std", "standarddeviation", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

#converting all words to lower case

namestochange<-gsub("Jerk", "jerk", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)


namestochange<-gsub("Mag", "mag", namestochange, ignore.case = FALSE, perl = FALSE,
                    fixed = TRUE, useBytes = FALSE)

names(tidied)=namestochange

# Therefore, the final tidy data set with the average of each 
# variable for each activity and each subject is:
tidied



