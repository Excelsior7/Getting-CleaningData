---
title: "CodeBook"
author: "Excelsior"
date: "01/28/2022"
output: html_document
---


## Study Design

The authors of the experiment that gave rise to this set of data tell us that the experiments have been carried out with a group of 30 volunteers within an age bracket of 19-48 years. Each person performed six activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING) wearing a smartphone (Samsung Galaxy S II) on the waist. Using its embedded accelerometer and gyroscope, the experimenters captured 3-axial linear acceleration and 3-axial angular velocity at a constant rate of 50Hz. The experiments have been video-recorded to label the data manually. The obtained dataset has been randomly partitioned into two sets, where 70% of the volunteers was selected for generating the training data and 30% the test data.

## Code book

Due to the requirements of the evaluation, I grouped the two datasets mentioned in the "Study Design" section, namely the training dataset and the test dataset. These two datasets contain the same 563 variables, and due to their partitions the datasets are totally independent in the sense that there is no relationship linking these two datasets; therefore I have placed all the rows of the test dataset under the rows of the training dataset. In doing so I simply reconstructed the initial dataset that was partioned in both by the experimenters.

> Each row represents the observations on a subject performing one of the six activities. 

Each row consists of :  

1. The subject identification : **subjects_id** (integer ranging in the interval [1-30]).  
2. The name of the activity performed by the subject : **activities** (one of the following six values: WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING)  
3. 561 variables follows the first two, representing measurements on the observations : all measurements come from or were derived from raw accelerometer and gyroscope signals that were captured at a constant rate of 50 Hz.

Due to the constraining size necessary to display the 561 variables on this document, these variables are available in this same repository in a file called **features.txt**.

> Each measurement is normalized et bounded within [-1,1].

### Concerning the first required tidy dataset (available in this repository) *features_datatable.csv* :

Due to the requirements of the evaluation, this dataset is a subset of the dataset specified above in the sense that it contains only those variables on which the experimenters applied the mean() or std() functions;

### Concerning the second required tidy dataset (available in this repository) *features_datatable_2.csv* :

This dataset is identical to *features_datatable.csv* in its structure. The difference lies in the information it transmits: 

For each pair (subject, activity) there are several rows, and thus several existing measures per variable and the objective of this second data set is to average these measures.