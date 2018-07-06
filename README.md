# Recognition-of-American-Sign-Language-ASL-through-human-gestures
To Develop a system which can understand and recognize the American Sign Language(ASL) through human gestures. 

1 Introduction
In this project, we attempt to develop a system which can understand and recognize the American Sign Language(ASL) through human gestures. A wristband sensor worn on both hands is used to collect data related to acceleration, gyroscope, orientation, electromyography and kinect data and is mined to understand what gesture the person has made. This could help a person who does not understand ASL to be able to communicate with a deaf/dumb person who does communicate in ASL. We use MATLAB to develop this software.


2 Project Phase 1
In the first phase, we went to the IMPACT lab at Brickyard, Tempe in order to collect data. One person wore wrist bands on both arms and made the gestures, “ABOUT”, “AND”, “CAN”, “COP” ,“DEAF”,“DECIDE”, “FATHER”, “FIND”, “GO OUT” and “HEARING” about 20 times each. The data collected from the sensors is stored in the form of CSV files. The time series data is sampled every 3 seconds. The frequency of sensors was found to be 15Hz. The data headers of the collected data are Accelerometer, Electromyogram, Gyroscope and Orientation.


3 Project Phase 2
The second phase of the project involves feature extraction and feature selection aspects of Data Mining. PCA was applied to the feature matrix to obtain the new feature matrix . From the feature matrix 7 features were extracted and multiplied with the feature matrix obtain a projection matrix . This projection matrix is used as a new feature matrix.

4 Project Phase 3
The third phase of the project involves the following steps,

A. A new column is added to the new feature matrix obtained from phase 2 for each user in order to create labels used for binary classification.

B. The data is shuffled and selected at random from the new feature matrix with labels generated.

C. 60% of the data for each user was used for training.

D. 40% of the remaining data was used for testing.

E. Support Vector Machines, Neural Networks and Decision Trees were used for training the machine .

F. The test dataset is then used to obtain the accuracy metrics Precision, Recall and F1 score for each user.

5 Project Phase 4
The fourth phase of the project involves the following steps,

A. A new column is added to the new feature matrix obtained from phase 2 for all users not used in training and testing datasets in order to create labels used for binary classification.

B. The training data is shuffled and selected at random from the new feature matrix with labels generated.

C. The testing data is also shuffled and selected at random from the new feature matrix with labels generated.

D. 10 users data is used for training.

E. The rest of the user data is used for testing.

F. Support Vector Machines, Neural Networks and Decision Trees were used for training the machine .

G. The test dataset is then used to obtain the accuracy metrics Precision, Recall and F1 score for all users in the test data.
