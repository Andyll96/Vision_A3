%Q3.6
fprintf("The approach taken in this question is that of linear partitioning\n");
fprintf("The first step being, making sure that the number of positive images matches\n");
fprintf("the number of negative images while ensuring that they're of the same dimension\n");
fprintf("(36x36). Once that's done we must oragnize our data set into our training data set\n");
fprintf("and our validation/testing set. From there we take the Histogram of Gaussians(HOG) of all the images.\n");
fprintf("We then feed the training images into our SVM and through means of the vl_svmtrain we get our optimal weight(w)\n");
fprintf("and bias(b) parameters for our loss function. We use these parameters and test them on our testing data set,\n");
fprintf("and we observe the accuracy. We may adjust using vl_svmtrain's lambda parameter or the cell size during the HOG stage\n");
