gettingcleaningdata
===================

repo to coursera class


This repo contains a R code called run_analysis and a Codebook.

As long as you have the Samsung data in your machine the run_analysis code does the following:

1- Reads the data and binds X_test and Y_test
2- Reads the data and binds X_train and Y_train
3- Creates a variable that indicates if the register comes from the train or the test data set (it's not necessary for this project but might be useful for other analysis)
4- Reads the activity labels data set
5- Merges the activity data set with the train plus test data set to specify the names of the activities
6- Reads the features data set to label the merged data set correctly
7- Selects only the measurements on the mean and standard deviation for each measurement
8- Creates a tidy data set with descriptive variables
