You can excecute the R file to run the whole analysis.

First the data is downloaded and unzipped. Then the actual test and train data are read into R. Then subject identifiers and activities related to the observations are read. Lastly, variables (features.txt) and activity labels are read.

Then, subject and activity ids are merged to test and train datas, and the resulting datas merged into a data set called "data_set".

Then, variables are labelled, and means and standard deviations of each measured variabels are calculated. After that, factor labels are assigned to activity ids.

Lastly, using a loop structure going over each subject-activity combination, means of each measured variable is calculated for corresponding subset of data. Resulting vectors are merged into to a matrix called "tidy_data". Then, variables are reordered and first two variables labeled. The matrix is transformed into a data frame, and written as txt file.
