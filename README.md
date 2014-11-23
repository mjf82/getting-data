readme run_analysis.r

The run_analysis script reads the following files into memory
 - List with features
 - List with activity descriptions
 - Test data
 - Training data

The training and test data are each a combination of a list of activity id's, subjects and result data. These are first combined into a data frame, one for test and one for training data. These are subsequently put below each other using rbind, and the headers of the columns are renamed using the list of features.

The activity descriptions are added using the merge function, after which the original activity id's are removed.

The tidy data set with summary data is obtained using the aggregate function, aggregating by subject and activity description, using the mean() function to summarise the data.

The data for this excercise was obtained from Ref [1].

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012
