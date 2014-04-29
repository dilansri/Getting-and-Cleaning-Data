Getting-and-Cleaning-Data
=========================


The `run_analysis.R` script will read data inside `UCI HAR Dataset` and provides `tidyData1` and `tidyData2` variables with cleaned data.

First it reads all the `train` and `test` data inside `UCI HAR Dataset` and merge it.

Then it takes only columns (variables) with mean and std in it.

Then the script merges activity labels with proper activities.

After than it merges the activity lables with the previously merged data set.

Finally it aggregate the dataset by activity and takes the means on selected columns (variables)
