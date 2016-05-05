# Coursera_Getting_and_Cleaning_Data_Project
This is the work I have done for coursera getting and cleaning data final project. The run_analysis.R script does the following:

1. Download the project data from the website and unzip it.
2. Load the activity and feature information. Clean up the feature labels. 
3. Load both the training and test datasets, selecting only the variables that contain a mean or standard deviation.
4. Merge those columns of subject, activity and test and training datasets. Rename vairable names using feature information.
5. Merge test and training datasets.
6. Create a tidy dataset that consists of the mean value of each vairable for each subject and activity pair.

The end result is shown in file tidy.txt.

