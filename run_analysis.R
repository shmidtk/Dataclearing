#Step 1 we load the Data in 7 separate var

features <- read.table("features.txt")

X_train <- read.table("./train/X_train.txt")
Y_train <- read.table("./train/Y_train.txt")
subject_train <- read.table("./train/subject_train.txt")

X_test <- read.table("./test/X_test.txt")
Y_test <- read.table("./test/Y_test.txt")
subject_test <- read.table("./test/subject_test.txt")

#Step 2 we combine test and train sets and change names of var for activities and subjects

SetX <- rbind(X_test, X_train)

SetY <- rbind(Y_test,Y_train)
SetY <- rename(SetY, Activity_Code = V1)

SetS <- rbind(subject_test, subject_train)
SetS <- rename(SetS, Subject_Code= V1)


#Step 3 - Give to all variables of Data names from Features.txt

names(Set) <- features[,2]

#step 4 - extract only mean and std variables from set

SetMean <- Set[,grep("mean",names(Set))]
SetStd <- Set[,grep("std",names(Set))]

#step 5 - combine subjects, activities and data in one table

SetTidy <- cbind(SetMean,SetStd)
SetTidy <- cbind(SetS, SetTidy)
SetTidy <- cbind(SetY, SetTidy)

#Step 6 - taking mean of all observasion on subject and activities base

AvrSet <- data.table(SetTidy)
AvrSet2 <- AvrSet[,lapply(.SD,mean),by=list(Activity_Code,Subject_Code)]

#Step 7 - write data

write.table(AvrSet2, "Average_tidy_set.txt",row.name=FALSE)

