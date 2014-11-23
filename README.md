data-cleaning
=============
# Get the data already saved in this folder
mytrain=read.table(".\\UCI HAR Dataset\\train\\X_train.txt") 
mytest=read.table(".\\UCI HAR Dataset\\test\\X_test.txt")
# binding the training and testing into a variable named comb_data
comb_data=rbind(mytab,mytest)
"getting the subject data
mytrain_sub=read.table(".\\UCI HAR Dataset\\train\\subject_train.txt") 
mytest_sub=read.table(".\\UCI HAR Dataset\\test\\subject_test.txt")
s <- rbind(mytrain_sub, mytest_sub)
names(s) <- "Subject"

# get the features
myfeat=read.table(".\\UCI HAR Dataset\\features.txt", sep="-", fill=T)

# get the means and stds
aa=which(myfeat[,2]=="mean()" | myfeat[,2]=="std()")
myfeat[aa,]   
comb_data_mean_std= comb_data[,aa]

myname=readLines(".\\UCI HAR Dataset\\features.txt"  )
colnames(comb_data_mean_std)= myname[aa]

# get the labels
train_label=readLines(".\\UCI HAR Dataset\\train\\y_train.txt")
test_label=readLines(".\\UCI HAR Dataset\\test\\y_test.txt")
label=c(train_label,test_label )
label=factor(label, labels=c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING"))
# combine the data together
New_data= cbind(comb_data_mean_std, "Activity"=label, s)
# finally, the question 5 data 
  A_data=aggregate(New_data[,1:66], list(New_data$Subject, New_data$Activity),mean ) 
write.table(A_data, "A_tidy_data.txt")
