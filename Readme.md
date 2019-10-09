## Getting and cleaning data course project

### This repository contains the following files:
1. run_analysis.R. This is the R script that was used in getting and cleaning the raw data set to generate the tidy data set. The script was used to perform the following tasks:
* Download the zipped raw data set and unzip it into a specified folder
* Merge components of the raw data set folder to generate a single data set
* Extract the mean and standard deviation for each measurement
* Label the variables appropriately
* Create a tidydataset with the average of each variable for each activity and each subject. 

2. tidydata.txt. This is the tidy data set with 180 observations and 88 variables. It is generated after running the run_analysis.R script

3. Code book.md. This briefly describes the raw data, transformations performed to clean the data, and the variables of the tidy(clean) data set.
