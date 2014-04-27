#reading train set
trainFilePath <- file.path("UCI HAR Dataset","train","X_train.txt")
dataTrain <- read.table(trainFilePath)

#reading test set
testFilePath <- file.path("UCI HAR Dataset","test","X_test.txt")
dataTest <- read.table(testFilePath)

#merging two sets
mergedData <- rbind(dataTrain,dataTest)

#reading featureslist
featuresFilePath <- file.path("UCI HAR Dataset","features.txt")
features <- read.table(featuresFilePath,sep=" ")

#getting column numbers of mean and std of each measurement
meanstdColumns <- grep("mean(?!Freq)|std",features$V2,perl=TRUE)
columnNames <- grep("mean(?!Freq)|std",features$V2,perl=TRUE,value=TRUE)

meanstdData <- mergedData[paste("V",meanstdColumns,sep="")]

names(meanstdData) <- columnNames

#activities in the data set
trainActivities <- read.table("UCI HAR Dataset/train/y_train.txt")
testActivities <- read.table("UCI HAR Dataset/test/y_test.txt")
allActivities <- rbind(trainActivities,testActivities)

#merging activity labels
activityLabels <- read.table("UCI HAR Dataset/activity_labels.txt")
activitiesWithLabels <- merge(allActivities,activityLabels,by.x="V1",by.y="V1")
names(activitiesWithLabels) <- c("ID","Label")

#merging activity labels with tidy data set 
tidyData1 <- cbind(activitiesWithLabels,meanstdData)

#aggregating data
tidyData2 <- aggregate(subset(tidyData1,select= c(-Label,-ID)),by=list(ID=tidyData1$ID),FUN=mean)
tidyData2 <- merge(activityLabels,tidyData2,by.x="V1",by.y="ID")

names(tidyData2)[names(tidyData2)=="V1"] = "ID"
names(tidyData2)[names(tidyData2)=="V2"] = "Activity"
