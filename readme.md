---
title: "ReadMe"
output: html_document
---

##Experiment##
Human Activity Recognition Using Smartphones Dataset - Version 1.0

##Description of Experiment##
The experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, we captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data. 

The sensor signals (accelerometer and gyroscope) were pre-processed by applying noise filters and then sampled in fixed-width sliding windows of 2.56 sec and 50% overlap (128 readings/window). The sensor acceleration signal, which has gravitational and body motion components, was separated using a Butterworth low-pass filter into body acceleration and gravity. The gravitational force is assumed to have only low frequency components, therefore a filter with 0.3 Hz cutoff frequency was used. From each window, a vector of features was obtained by calculating variables from the time and frequency domain. See 'features_info.txt' for more details. 

For each record it is provided:
======================================
- Triaxial acceleration from the accelerometer (total acceleration) and the estimated body acceleration.
- Triaxial Angular velocity from the gyroscope. 
- A 561-feature vector with time and frequency domain variables. 
- Its activity label. 
- An identifier of the subject who carried out the experiment.
Data was obtained from
[enter website address]


Raw data consists of the following files:

- 'features.txt': List of all features (561 items)

- 'activity_labels.txt':  (6 items) Links the class labels with their activity name.

- X_train.txt: Training set.

- y_train.txt: Training labels.

- X_test.txt: Test set.

- y_test.txt: Test labels


##Description of the manipulation of data done to create the single data set##
- Read in the activity labels.
- Read in the full list of features - to be used to identify the columns in the test & training data.
- Read in the subject_test data and the subject_train data to produce a combined data set of 10,299 rows x 1 column - contains the subject no.
- Read in the Y_test data and the Y_train data to produce a combined data set of 10,299 rows x 1 column - contains the activity no.
- Read in the X_test data and the X_train data to produce a combined data set of 10,299 rows x 561 column.

Training data sets was appended to the bottom of the test data sets to ensure that the data was not placed out of order when combined with other data.

Produced a subset of this data that only included those features relating to mean or standard deviations.  (This did not include features where the measurement was meanFreq).  The resulting data set was 10,299 rows x 66 columns.
Combined the files into a consolidated data set containing subject no, activity no & 
Analysed this resultant data so that the mean of the relevant features (mean & standard deviation measurements) was averaged for each subject number & activity number.

