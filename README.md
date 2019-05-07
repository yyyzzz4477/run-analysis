# run-analysis
# a code book that describes the variables, the data, and any transformations or work that you performed to clean up the data called CodeBook.md.
# repo explains how all of the scripts work and how they are connected.

## download the data from the web and then unzip the data set.

## Merge
1. merge the train data-traindata
2. merge the test data-testdata
3. merge the traindata and testdata-data

## Mean and Deviation Selection
1. read the file contains features
2. select the index that contains "mean" or "std"
3. select the index from data that only contains "subject", "activity", and "mean/std"
4. name the column

## Name the activity
1. read the file contains activity names
2. names the column of the file
3. merge the file and data by activity
4. mutate the activity names into activity and delete the activityNames column

## Label the data
1. delete the "()" from the name
2. use "time" to replace the "t" at the beginning
2. use "frequency" to replace the "f" at the beginning

## Create the data set with mean
1. group the data by subject and activity
2. summarize each column of data by calculating the mean
3. create the table
