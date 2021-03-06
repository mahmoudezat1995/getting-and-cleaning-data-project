library(data.table)
library(dplyr)
### Read Supporting Metadata

        setwd("C:/Users/mahmoud/Documents/R_data/UCI HAR Dataset")
        featureNames <- read.table("./features.txt")
        activityLabels <- read.table("./activity_labels.txt")
        
### Read training data
        
        subjectTrain <- read.table("./train/subject_train.txt")
        activityTrain <- read.table("./train/y_train.txt")
        featuresTrain <- read.table("./train/X_train.txt")
        
### Read test data
        
        subjectTest <- read.table("./test/subject_test.txt")
        activityTest <- read.table("./test/y_test.txt")
        featuresTest <- read.table("./test/X_test.txt")
        
### Merge the training and the test sets to create one data set
        
        subject <- rbind(subjectTrain, subjectTest)
        activity <- rbind(activityTrain, activityTest)
        features <- rbind(featuresTrain, featuresTest)
        
### Naming the columns
        
        colnames(features) <- t(featureNames[2])
        
### Merge the data
        
        colnames(activity) <- "Activity"
        colnames(subject) <- "Subject"
        completeData <- cbind(features,activity,subject)
###  Extracts only the measurements on the mean and standard deviation
        columnsWithMeanSTD <- grep(".*Mean.*|.*Std.*", names(completeData), ignore.case=TRUE)
        requiredColumns <- c(columnsWithMeanSTD, 562, 563)
        extractedData <- completeData[,requiredColumns]
### Uses descriptive activity names
        
        extractedData$Activity <- as.character(extractedData$Activity)
        for (i in 1:6){
                extractedData$Activity[extractedData$Activity == i] <- as.character(activityLabels[i,2])
        }
        extractedData$Activity <- as.factor(extractedData$Activity)
        
### Appropriately labels the data set with descriptive variable names
        
        names(extractedData)<-gsub("Acc", "Accelerometer", names(extractedData))
        names(extractedData)<-gsub("Gyro", "Gyroscope", names(extractedData))
        names(extractedData)<-gsub("BodyBody", "Body", names(extractedData))
        names(extractedData)<-gsub("Mag", "Magnitude", names(extractedData))
        names(extractedData)<-gsub("^t", "Time", names(extractedData))
        names(extractedData)<-gsub("^f", "Frequency", names(extractedData))
        names(extractedData)<-gsub("tBody", "TimeBody", names(extractedData))
        names(extractedData)<-gsub("-mean()", "Mean", names(extractedData), ignore.case = TRUE)
        names(extractedData)<-gsub("-std()", "STD", names(extractedData), ignore.case = TRUE)
        names(extractedData)<-gsub("-freq()", "Frequency", names(extractedData), ignore.case = TRUE)
        names(extractedData)<-gsub("angle", "Angle", names(extractedData))
        names(extractedData)<-gsub("gravity", "Gravity", names(extractedData))
###  From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject
        
        extractedData$Subject <- as.factor(extractedData$Subject)
        extractedData <- data.table(extractedData)
        tidyData <- aggregate(. ~Subject + Activity, extractedData, mean)
        tidyData <- tidyData[order(tidyData$Subject,tidyData$Activity),]
        write.table(tidyData, file = "Tidy.txt", row.names = FALSE)
        
        
        
        