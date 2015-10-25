The following explain each steps one by one
# 
# read the train data
train_data <- read.table("dataset/train/X_train.txt")
train_subject <- read.table("dataset/train/subject_train.txt")
train_activity <- read.table("dataset/train/y_train.txt")

#
# read the test data
test_subject <- read.table("dataset/test/subject_test.txt")
test_data <- read.table("dataset/test/X_test.txt")
test_activity <- read.table("dataset/test/y_test.txt")

#
# column combine x and y of train data to become train_activity 
# to become 7352 rows and 562 columns
# > dim(train_data_activity)
# [1] 7352  562
#
train_data_activity <- cbind(train_data, train_activity)

#
# column combine of train_activity and subject
# to become 7352 rows and 563 columns
# > dim(train_data_activity_subject)
# [1] 7352  563
train_data_activity_subject <- cbind(train_data_activity, train_subject)


# column combine x and y of test data to become test_activity
# to become 2947 rows and 562 columns
# > dim(test_data_activity)
# [1] 2947  562
test_data_activity <- cbind(test_data, test_activity)

# column combine test_activity and subject 
# to become 2947 rows and 563 columns
# > dim(test_data_activity_subject)
# [1] 2947  563
test_data_activity_subject <- cbind(test_data_activity, test_subject)

# No.1
# Merge the training and test sets to create one data set
# 
# > dim(dataset)
# [1] 10299   563
dataset <- rbind(train_data_activity_subject, test_data_activity_subject)

# read features label
feature <- read.table("dataset/features.txt")
# extract second column names and remove parentheses ()
transform_header <- gsub("\\(\\)","",feature$V2)
# transform header names from "-" sign to "_" sign
transform_header <- gsub("-","_",transform_header)

# assign column names to dataset with transform_header, activity, volunteer
colnames(dataset) <- c(transform_header,"activity","volunteer")

# extract the header name index which has name ending with 'mean' or 'std'
# > meanstdfeature
# [1] 201 202 214 215 227 228 240 241 253 254 503 504 516 517 529 530 542 543
meanstdfeature <- grep("mean$|std$", transform_header)

#
# result header
# > header
#  [1] "tBodyAccMag_mean"          "tBodyAccMag_std"           "tGravityAccMag_mean"      
#  [4] "tGravityAccMag_std"        "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"      
#   [7] "tBodyGyroMag_mean"         "tBodyGyroMag_std"          "tBodyGyroJerkMag_mean"    
#   [10] "tBodyGyroJerkMag_std"      "fBodyAccMag_mean"          "fBodyAccMag_std"          
#   [13] "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"   "fBodyBodyGyroMag_mean"    
#   [16] "fBodyBodyGyroMag_std"      "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 
#
# extract the actual headers
header <- transform_header[meanstdfeature]

# No.2 
# Extracts only the measurements on the mean and standard deviation for each measurement. 
#
# extract data with meansurements of mean or standard deviation and column of activity and volunteer number 
extract <- dataset[,c(header,"activity","volunteer")]

# read activity labels into data frame activty_labels and assign column names
# >  activty_labels
#    activity     activity_label
#  1        1            WALKING
#  2        2   WALKING_UPSTAIRS
#  3        3 WALKING_DOWNSTAIRS
#  4        4            SITTING
#  5        5           STANDING
#  6        6             LAYING
activity_labels <- read.table("dataset/activity_labels.txt")
colnames(activity_labels) <- c("activity","activity_label")

#
# No. 3,4
# Uses descriptive activity names to name the activities in the data set
# Appropriately labels the data set with descriptive variable names. 
#
# merge the extracts with activity labels with common column name 'activty'
# > dim(result)
# [1] 10299    21
# >  head(result) (showing first 3 rows)
# activity tBodyAccMag_mean tBodyAccMag_std tGravityAccMag_mean tGravityAccMag_std
#  1        5       -0.9594339      -0.9505515          -0.9594339         -0.9505515
#  2        5       -0.9792892      -0.9760571          -0.9792892         -0.9760571
#  3        5       -0.9837031      -0.9880196          -0.9837031         -0.9880196
#   tBodyAccJerkMag_mean tBodyAccJerkMag_std tBodyGyroMag_mean tBodyGyroMag_std tBodyGyroJerkMag_mean
#  1           -0.9933059          -0.9943364        -0.9689591       -0.9643352            -0.9942478
#  2           -0.9912535          -0.9916944        -0.9806831       -0.9837542            -0.9951232
#  3           -0.9885313          -0.9903969        -0.9763171       -0.9860515            -0.9934032
#   tBodyGyroJerkMag_std fBodyAccMag_mean fBodyAccMag_std fBodyBodyAccJerkMag_mean
#  1           -0.9913676       -0.9521547      -0.9561340               -0.9937257
#  2           -0.9961016       -0.9808566      -0.9758658               -0.9903355
#  3           -0.9950910       -0.9877948      -0.9890155               -0.9892801
#   fBodyBodyAccJerkMag_std fBodyBodyGyroMag_mean fBodyBodyGyroMag_std fBodyBodyGyroJerkMag_mean
#  1              -0.9937550            -0.9801349           -0.9613094                -0.9919904
#  2              -0.9919603            -0.9882956           -0.9833219                -0.9958539
#  3              -0.9908667            -0.9892548           -0.9860277                -0.9950305
#   fBodyBodyGyroJerkMag_std volunteer activity_label
#  1               -0.9906975         1       STANDING
#  2               -0.9963995         1       STANDING
#  3               -0.9951274         1       STANDING
#
result <- merge(extract,activity_labels, sort=FALSE)


# extract the variable names, take out volunteer, activity, activity_label
# > varnames
# [1] "tBodyAccMag_mean"          "tBodyAccMag_std"           "tGravityAccMag_mean"      
# [4] "tGravityAccMag_std"        "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"      
# [7] "tBodyGyroMag_mean"         "tBodyGyroMag_std"          "tBodyGyroJerkMag_mean"    
# [10] "tBodyGyroJerkMag_std"      "fBodyAccMag_mean"          "fBodyAccMag_std"          
# [13] "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"   "fBodyBodyGyroMag_mean"    
# [16] "fBodyBodyGyroMag_std"      "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 
varnames <- names(result)[2:19]


#
# reorganize result dataframe into wide format
#
resultmelt <- melt(result, id=c("volunteer", "activity_label"), measure.vars=varnames)
#
#
# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
#
# find the mean for each variable
#> dim(avgresult)
# [1] 180  20
#
# > head(avgresult)
#  volunteer     activity_label tBodyAccMag_mean tBodyAccMag_std tGravityAccMag_mean tGravityAccMag_std
#  1         1             LAYING      -0.84192915     -0.79514486         -0.84192915        -0.79514486
#  2         1            SITTING      -0.94853679     -0.92707842         -0.94853679        -0.92707842
#  3         1           STANDING      -0.98427821     -0.98194293         -0.98427821        -0.98194293
#  4         1            WALKING      -0.13697118     -0.21968865         -0.13697118        -0.21968865
#  5         1 WALKING_DOWNSTAIRS       0.02718829      0.01988435          0.02718829         0.01988435
#  6         1   WALKING_UPSTAIRS      -0.12992763     -0.32497093         -0.12992763        -0.32497093
#   tBodyAccJerkMag_mean tBodyAccJerkMag_std tBodyGyroMag_mean tBodyGyroMag_std tBodyGyroJerkMag_mean
#  1          -0.95439626         -0.92824563       -0.87475955       -0.8190102            -0.9634610
#  2          -0.98736420         -0.98412002       -0.93089249       -0.9345318            -0.9919763
#  3          -0.99236779         -0.99309621       -0.97649379       -0.9786900            -0.9949668
#  4          -0.14142881         -0.07447175       -0.16097955       -0.1869784            -0.2987037
#  5          -0.08944748         -0.02578772       -0.07574125       -0.2257244            -0.2954638
#  6          -0.46650345         -0.47899162       -0.12673559       -0.1486193            -0.5948829
#   tBodyGyroJerkMag_std fBodyAccMag_mean fBodyAccMag_std fBodyBodyAccJerkMag_mean fBodyBodyAccJerkMag_std
#  1           -0.9358410      -0.86176765      -0.7983009              -0.93330036              -0.9218040
#  2           -0.9883087      -0.94778292      -0.9284448              -0.98526213              -0.9816062
#  3           -0.9947332      -0.98535636      -0.9823138              -0.99254248              -0.9925360
#  4           -0.3253249      -0.12862345      -0.3980326              -0.05711940              -0.1034924
#  5           -0.3065106       0.09658453      -0.1865303               0.02621849              -0.1040523
#  6           -0.6485530      -0.35239594      -0.4162601              -0.44265216              -0.5330599
#    fBodyBodyGyroMag_mean fBodyBodyGyroMag_std fBodyBodyGyroJerkMag_mean fBodyBodyGyroJerkMag_std
#  1            -0.8621902           -0.8243194                -0.9423669               -0.9326607
#  2            -0.9584356           -0.9321984                -0.9897975               -0.9870496
#  3            -0.9846176           -0.9784661                -0.9948154               -0.9946711
#  4            -0.1992526           -0.3210180                -0.3193086               -0.3816019
#  5            -0.1857203           -0.3983504                -0.2819634               -0.3919199
#  6            -0.3259615           -0.1829855                -0.6346651               -0.6939305
avgresult <- dcast(resultmelt, volunteer + activity_label ~ variable, mean)

write.table(avgresult, file="result.txt", row.name=FALSE)
