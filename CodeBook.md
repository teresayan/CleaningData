Explaination of variables in run_analysis.R


train_data  - raw data frame contain x values of train data,   7352 rows and 561 columns
train_subject - raw data frame contain subject values of train data, 7352 rows and 1 column
train_activity - raw data frame contain activty value of train data, 7352 rows and 1 column

test_subject - raw data frame contain subject values of test data, 2947 rows and 1 column
test_data - raw data frame contain x values of test data, 2947 rows and 561 column
test_activity - raw data frame contain activity value of test data, 2947 rows and 1 column

train_data_activity - column combine x and y of train data to become train_activity, 7352 rows and 562 column
train_data_activity_subject - column combine of train_activity and subject, 7352 rows and 563 column
test_data_activity - column combine x and y of test data to become test_activity, 2947 rows and 562 columns
test_data_activity_subject - column combine test_activity and subject, 2947 rows and 563 columns

dataset - Merge the training and test sets to create one data set, still raw dataset, 10299 rows and 563 columns

feature - data frame with features label, 561 rows and 2 columns
transform_header - vector of feature label which is extract second column names of feature and remove parentheses (), and change from "-" to "_"
colnames(dataset) - column names of dataset, transform_header,"activity","volunteer"

meanstdfeature - vector contain header name index of feature which has name ending with 'mean' or 'std'
                  [1] 201 202 214 215 227 228 240 241 253 254 503 504 516 517 529 530 542 543

# > header
#  [1] "tBodyAccMag_mean"          "tBodyAccMag_std"           "tGravityAccMag_mean"      
#  [4] "tGravityAccMag_std"        "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"      
#   [7] "tBodyGyroMag_mean"         "tBodyGyroMag_std"          "tBodyGyroJerkMag_mean"    
#   [10] "tBodyGyroJerkMag_std"      "fBodyAccMag_mean"          "fBodyAccMag_std"          
#   [13] "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"   "fBodyBodyGyroMag_mean"    
#   [16] "fBodyBodyGyroMag_std"      "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 
#
header - contain the actual headers with mean and standard deviation only

extract - extract data with meansurements of mean or standard deviation and column of activity and volunteer number

# read activity labels into data frame activty_labels and assign column names
# >  activty_labels
#    activity     activity_label
#  1        1            WALKING
#  2        2   WALKING_UPSTAIRS
#  3        3 WALKING_DOWNSTAIRS
#  4        4            SITTING
#  5        5           STANDING
#  6        6             LAYING
activity_labels - data frame contain activity labels with column name 'activity' and 'activity_label'

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
result - data frame which is the merge the extracts with activity labels with common column name 'activty'


# > varnames
# [1] "tBodyAccMag_mean"          "tBodyAccMag_std"           "tGravityAccMag_mean"      
# [4] "tGravityAccMag_std"        "tBodyAccJerkMag_mean"      "tBodyAccJerkMag_std"      
# [7] "tBodyGyroMag_mean"         "tBodyGyroMag_std"          "tBodyGyroJerkMag_mean"    
# [10] "tBodyGyroJerkMag_std"      "fBodyAccMag_mean"          "fBodyAccMag_std"          
# [13] "fBodyBodyAccJerkMag_mean"  "fBodyBodyAccJerkMag_std"   "fBodyBodyGyroMag_mean"    
# [16] "fBodyBodyGyroMag_std"      "fBodyBodyGyroJerkMag_mean" "fBodyBodyGyroJerkMag_std" 
varnames - vector contain the variable names only, exclude 'volunteer', 'activity', 'activity_label'



> head(resultmelt)
  volunteer activity_label         variable      value
  1         1       STANDING tBodyAccMag_mean -0.9594339
  2         1       STANDING tBodyAccMag_mean -0.9792892
  3         1       STANDING tBodyAccMag_mean -0.9837031
  4         1       STANDING tBodyAccMag_mean -0.9865418
  5         1       STANDING tBodyAccMag_mean -0.9928271
  6         1       STANDING tBodyAccMag_mean -0.9942950
resultmelt - wide format of data frame result, reorganization, with id = c("volunteer", "activity_label") and  measure.vars=varnames


# From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.
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
avgresult - final result data frame which contain the mean for each variable for each activity and each subject

