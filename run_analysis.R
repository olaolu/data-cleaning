mytrain=read.table(".\\UCI HAR Dataset\\train\\X_train.txt") 
mytest=read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
comb_data=rbind(mytab,mytest)
mytrain_sub=read.table(".\\UCI HAR Dataset\\train\\subject_train.txt") 
mytest_sub=read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
s <- rbind(mytrain_sub, mytest_sub)
names(s) <- "Subject"

myfeat=read.table(".\\UCI HAR Dataset\\features.txt", sep="-", fill=T)
aa=which(myfeat[,2]=="mean()" | myfeat[,2]=="std()")
myfeat[aa,] # copy  from feature with only mean and std
comb_data_mean_std= comb_data[,aa]

myname=readLines(".\\UCI HAR Dataset\\features.txt"  )
colnames(comb_data_mean_std)= myname[aa]

train_label=readLines(".\\UCI HAR Dataset\\train\\y_train.txt")
test_label=readLines(".\\UCI HAR Dataset\\test\\y_test.txt")
label=c(train_label,test_label )
label=factor(label, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
New_data= cbind(comb_data_mean_std, "Activity"=label, s)
  A_data=aggregate(New_data[,1:66], list(New_data$Subject, New_data$Activity),mean ) 
write.table(A_data, "A_tidy_data.txt")
