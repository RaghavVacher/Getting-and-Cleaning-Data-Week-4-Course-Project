#dply and data.table have been loaded before-hand and the files have also been downloaded


#reading the files provided;named the files based on the README file suggests

activitylabels <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\activity_labels.txt"
                             , header = F)
features <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\features.txt", header = F)

x_test <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\X_test.txt", header = F)
x_train <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\X_train.txt", header = F)

y_test <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\y_test.txt", header = F)
y_train <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\y_train.txt", header = F)

subject_train <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\train\\subject_train.txt", header = F)
subject_test <- read.table("C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\test\\subject_test.txt", header = F)

#merging the data.frames to make it look clean and organized

x_total <- rbind(x_test, x_train)
y_total <- rbind(y_test, y_train)
subject_total <- rbind(subject_test, subject_train)

colnames(subject_total) <- "subject"


#Extracts only the measurements on the mean and standard deviation for each measurement

selected_var <- features[grep("mean\\(\\)|std\\(\\)",features[,2]),]
x_total <- x_total[,selected_var[,1]]

colnames(y_total) <- "activity"
y_total$activitylabel <- factor(y_total$activity, labels = as.character(activitylabels[,2]))
activitylabels <- y_total[,-1]

# Appropriately labels the data set with descriptive variable names.
colnames(x_total) <- features[selected_var[,1],2]

# From the data set in step 4, creates a second, independent tidy data set with the average
# of each variable for each activity and each subject.
colnames(subject_total) <- "subject"
total <- cbind(x_total, activitylabels, subject_total)
total_mean <- total %>% group_by(activitylabels, subject) %>% summarize_each(funs(mean))
write.table(total_mean, file = "C:\\Users\\Hp\\Downloads\\getdata_projectfiles_UCI HAR Dataset\\UCI HAR Dataset\\tidydata.txt", row.names = FALSE, col.names = TRUE)
