trainData<-read.csv("train/X_train.txt", sep="", header=FALSE)
testData<-read.csv("test/X_test.txt",sep="",header=FALSE)
colNames<-read.csv("features.txt",sep="",header=FALSE)
colnames(trainData)<-colNames$V2
colnames(testData)<-colNames$V2

# Not sure whether it's necessary but for tracking i'll add a column to keep track of
# which are training and which are test data.

testData$origin<-"test"
trainData$origin<-"train"

trainAct<-read.csv("train/y_train.txt",sep="",header=FALSE)
trainSub<-read.csv("train/subject_train.txt",sep="",header=FALSE)
testAct<-read.csv("test/y_test.txt",sep="",header=FALSE)
testSub<-read.csv("test/subject_test.txt",sep="",header=FALSE)

actKey<-read.csv("activity_labels.txt",sep="",header=FALSE)

# we append the test data behind the training data:
allData<-rbind(trainData,testData)

# then we get all the mean & standard deviation data (along with the origin column)
# there are a few instances of "meanFreq" that would throw us off if we let them
# but careful use of regexes removes those so we have 33 mean columns and 33 std columns:
meanStdData<-allData[,grepl("mean[[:punct:]]", colnames(allData))|grepl("std",colnames(allData))|grepl("origin",colnames(allData))]

# initialize new variables, then use a loop to add activity descriptions for each row:
trainDescAct<-0
testDescAct<-0
for (i in seq(1,nrow(actKey))){trainDescAct[as.factor(trainAct$V1)==i]<-as.character(actKey$V2[i])}
for (i in seq(1,nrow(actKey))){testDescAct[as.factor(testAct$V1)==i]<-as.character(actKey$V2[i])}

# add a column to the mean & std dev dataset for activity names:
tmp1<-data.frame(trainDescAct)
tmp2<-data.frame(testDescAct)
colnames(tmp1)<-c("actDescr")
colnames(tmp2)<-c("actDescr")
meanStdData$actDescr<-rbind(tmp1,tmp2)

# add a column to the mean & std dev dataset for subject index:
meanStdData$subj<-rbind(trainSub,testSub)

# Take the averages by the factors indicated:
tidySet<-aggregate(meanStdData, by=list(meanStdData$actNames$tmp, meanStdData$subj$V1),FUN="mean")[,c(-69,-70,-71,-72)]

# Export the tidy dataset
write.csv(tidySet, file="tidySetExport.txt")
