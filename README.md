# Getting and Cleaning Data - Course Project

This is the course project for the Getting and Cleaning Data Coursera course.
The R script, `run_analysis.R`, does the following:

1. Checks to see if the data file exists, if not downloads the datafile
2. Load the activity and feature info
3. Loads both datasets keeping only the columns refleting a mean or std dev
4. merges subject and activity data
6. Converts the `activity` and `subject` columns into factors
7. Creates a tidy dataset that consists of the average (mean) value of each
   variable for each subject and activity pair. `tidy.txt`.
