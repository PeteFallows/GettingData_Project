setwd("C:/Users/Pete/Documents/R-files/Course3/UCI HAR Dataset")
home_directory = "C:/Users/Pete/Documents/R-files/Course3/UCI HAR Dataset"

# Course Project - Getting and Cleaning Data
# Instructions:
#You should create one R script called run_analysis.R that does the following. 
#1. Merges the training and the test sets to create one data set.
#2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#3. Uses descriptive activity names to name the activities in the data set
#4. Appropriately labels the data set with descriptive variable names. 
#5. From the data set in step 4, creates a second, independent tidy data set with the average of
# each variable for each activity and each subject.

# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Part 1


# Data is in subdirectory "test" or "train"
setwd(home_directory)
setwd("./test")
#list.files()
files_list_test = list.files(pattern="*.txt")

setwd(home_directory)
setwd("./train")
#list.files()
files_list_train = list.files(pattern="*.txt")

#Appears that file names are identical between test and train directories
# apart from having "test" or "train" in the file name

# Now have lists for the files in each of the directories for test & train.
# files_list_test, files_list_train

# Read files in files_list_test (3)
setwd(home_directory)
setwd("./test")



# Read data in & assign to variable name
# Done one at a time, but ideally would have in a loop
dataset_test_1 = read.table(files_list_test[1])
# names are V1 only
dataset_test_2 = read.table(files_list_test[2])
# headers have been created as V1 ... V561
dataset_test_3 = read.table(files_list_test[3])
# names are V1 only


setwd(home_directory)
setwd("./train")
dataset_train_1 = read.table(files_list_train[1])
# names are V1 only
dataset_train_2 = read.table(files_list_train[2])
# headers have been created as V1 ... V561
dataset_train_3 = read.table(files_list_train[3])
# names are V1 only

# Observations on data
# (File1) subject_test & subject_train contain values from 1 to 30, and are distinct.
# That is, there are no values in the test data set that are also contained in the train data set.

# (File2) x_test & x_train contain values from -1 to 1

# (File3) y_test & y_train contain values from 1 to 6

# Dimensions on data
# (File1) _test: 2947 x 1
# (File1) _train: 7352 x 1
# (File2) 2947 / 7352 x 561 columns
# (File3) 2947 / 7352 x 1 column




# Merge files
setwd(home_directory)

# Merges files - with 10,299 records
#dataset_merge_1 = merge(dataset_test_1, dataset_train_1, by.x ="V1", all = TRUE)
# Append training files to the bottom of the test files
# Could also use append function
dataset_merge_1 = rbind(dataset_test_1, dataset_train_1)
dataset_merge_2 = rbind(dataset_test_2, dataset_train_2)
dataset_merge_3 = rbind(dataset_test_3, dataset_train_3)


# Description of merged files
# dataset_merge_1 = subject_test + subject_train (10,299 rows x 1 column)
# dataset_merge_2 = X_test + X_train (10,299 rows x 561 columns)
# dataset_merge_3 = Y_test + Y_train (10,299 rows x 1 column)


# Rename merged files
subject_merge = dataset_merge_1
X_merge = dataset_merge_2
Y_merge = dataset_merge_3


# Remove temporary data sets
rm(dataset_merge_1, dataset_merge_2, dataset_merge_3)

# Result - now have merged data set with:
# subject_merge, X_merge & Y_merge


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Part 2


# Get features & labels
features = read.table("features.txt")
colnames(features) = c("Feature No", "Feature")


#Extract features with mean, std
# Exact match to remove any instances of meanFreq
mean_features = grep("mean()", features$Feature, fixed = TRUE)
std_features = grep("std()", features$Feature, fixed = TRUE)

mean_std_features = c(mean_features, std_features)
mean_std_features_sorted = mean_std_features[order(mean_std_features)]

X_subset = X_merge[,mean_std_features_sorted]

# X_subset is the subset of the merged data set, containing only mean & std variables
# dimension is 10,299 row x 66 columns


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Part 3

# Get activity labels
setwd(home_directory)
activity_labels = read.table("activity_labels.txt")
colnames(activity_labels) = c("Activity No", "Activity")


# Output is:
#Activity No           Activity
#           1            WALKING
#           2   WALKING_UPSTAIRS
#           3 WALKING_DOWNSTAIRS
#           4            SITTING
#           5           STANDING
#           6             LAYING



# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Part 4

#mean_std_features_sorted contains the numbers of the columns included in X_subset

subset_headers = features[mean_std_features_sorted, 2]

colnames(X_subset) = c(as.character(subset_headers))

# Result is X_subset now has headers with mean() or std() descriptions

# Create a single data set which includes: X_subset, Y_merge & subject_merge

colnames(subject_merge) = c("Subject_No")
colnames(Y_merge) = c("Activity_No")

dataset_temp = cbind(subject_merge, Y_merge)

dataset = cbind(dataset_temp, X_subset)


# - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - 
# Part 5


# Average of each variable for each activity & subject

# initialise or reset full_output as empty data frame
full_output = data.frame()

for (j in 1:6) {
  for (i in 1:30){
    x = subset(dataset, Subject_No == i & Activity_No == j)
    output = sapply(x,mean,na.rm=TRUE)
    
    full_output = rbind(full_output,output)
  }
}

colnames(full_output) = c(names(dataset))

# output to a text file
write.table(full_output, file ="dataset.txt", sep=",", row.names = FALSE)



