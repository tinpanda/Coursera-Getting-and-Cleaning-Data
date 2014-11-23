Code book:

Object "data_frame" contains all the measured data. The data is in wide format, each row corresponds to a individual-activity combination. Individuals are assigned by variable "Person_id" and activities by variable "Activity". Activities are labelled as in "activity_labels.txt" file in the data source. Measured variables are named as in the "features.txt" in the original data source.

Object "tidy_data" contains mean of each measured variable for each individual-activity combination. As with data frame "data_set", subjects and actitivies are assigned with variables "Person_id" and "Activity", respectively. Means of the variables are represented with variables named after corresponding measure. They are calculated as mean of a measure for given subject and activity (for example, subject 1 and activity "Standing").
