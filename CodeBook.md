# Cleaning and Getting Data course project code book 

# Analysis process

The analysis script, run_analysis.R reads in the processed experiment data and performs a number of steps to get it into summary form.

- Both the processed test and training datasets are read in and merged into one data frame.
- The data columns are then given names based on the features.txt file.
- Columns that hold mean or standard deviation measurements are selected from the dataset, while the other measurement columns are excluded from the rest of the analysis.
- The activity identifiers are replaced with the activity labels based on the activity_labels.txt file.
- Invalid characters (() and - in this case) are removed from the column names. Also, duplicate phrase BodyBody in some columns names is -replaced with Body.
- The data is then grouped by subject and activity, and the mean is calculated for every measurement column.
- Finally, the summary dataset is written to a file, Tidy.txt.

 Each line in run_analysis.R is commented. Reference the file for more information on this process.

# Columns in output file
The columns included in the output file are listed below:

-subject_id - The id of the experiment participant.
-activity_labels - The name of the activity that the measurements correspond to, like LAYING or WALKING.
