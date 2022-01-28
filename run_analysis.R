# USED PACKAGES : data.table;

library(data.table);

# DOWNLOAD ZIP FILE AND STORE IT IN THE WORKING DIRECTORY UNDER THE NAME : dataset.zip #
# UNZIP dataset.zip INTO THE WORKING DIRECTORY, THIS CREATE THE FOLDER 'UCI HAR Dataset' CONTAINING THE DATAs #
# RENAME FOLDER 'UCI HAR DATASET' TO 'uci_har_dataset' # 
if(file.exists("dataset.zip") == FALSE) {
  download.file("https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip", destfile = "dataset.zip");
  unzip("dataset.zip");
  file.rename("UCI HAR Dataset","uci_har_dataset");
}

# GROUP subject_train.txt AND subject_test.txt INTO ONE VECTOR: subjects_id # 
subject_train <- readLines("./uci_har_dataset/train/subject_train.txt");
subject_test <- readLines("./uci_har_dataset/test/subject_test.txt");
subjects_id <- c(subject_train, subject_test);


# GROUP y_train.txt AND y_test.txt INTO ONE VECTOR: activities #
act_train <- readLines("./uci_har_dataset/train/y_train.txt");
act_test <- readLines("./uci_har_dataset/test/y_test.txt");
activities <- c(act_train, act_test);

# TRANSFORM EACH LABEL BY ITS DESCRIPTIVE ACTIVITY NAME #
activities_labels <- c("WALKING","WALKING_UPSTAIRS","WALKING_DOWNSTAIRS","SITTING","STANDING","LAYING");
activities <- as.character(activities);
activities <- sapply(activities, 
                     function(label) { 
                       sub(pattern = label, replacement = activities_labels[as.numeric(label)], x = label, fixed = TRUE) 
                      }
                    );

# GROUP X_train.txt AND X_test.txt INTO ONE DATA TABLE: features_datatable #
features_datatable_train <- fread("./uci_har_dataset/train/X_train.txt");
features_datatable_test <- fread("./uci_har_dataset/test/X_test.txt");
features_datatable <- rbindlist(l = list("dt1" = features_datatable_train, "dt2" = features_datatable_test));

# EXTRACTS MEAN AND STD MEASUREMENTS #
features <- fread("./uci_har_dataset/features.txt", select = 2);
mean_std_measurements_indices <- grep("mean\\(\\)|std\\(\\)",features[,V2]);
features_datatable <- features_datatable[, ..mean_std_measurements_indices];

# LABELS EACH COLUMNS USING DESCRIPTIVE VARIABLE NAMES #
names(features_datatable) <- grep("mean\\(\\)|std\\(\\)",features[,V2], value = TRUE);

# BIND subjects_id AND activities TO features_datatable DATATABLE # 
features_datatable <- cbind(subjects_id, activities, features_datatable);

# WRITE DATATABLE FILE : features_datatable.csv #
if(file.exists("./features_datatable.csv") == FALSE) {
  write.csv(features_datatable, "./features_datatable.csv");
}


###################################### -- STEP 5 -- ###############################################

features_datatable_2 <- features_datatable[, lapply(.SD, mean), by = .(subjects_id, activities), .SDcols = 3:68];

# WRITE DATATABLE FILE 2 : features_datatable_2.csv #
if(file.exists("./features_datatable_2.csv") == FALSE) {
  write.csv(features_datatable_2, "./features_datatable_2.csv");
}



