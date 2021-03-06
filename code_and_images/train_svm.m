%Andy Llactahuamani
%500640181
%Q3.4
close all
clear
clc
run('C:\Users\Andys\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')
load('pos_neg_feats.mat')

feats = cat(1,pos_feats_train,neg_feats_train);
labels = cat(1,ones(pos_nImages_train,1),-1*ones(neg_nImages_train,1));

lambda = 0.05;
[w,b] = vl_svmtrain(feats',labels',lambda);

fprintf('Classifier performance on train data:\n')
confidences = [pos_feats_train; neg_feats_train]*w + b;

[tp_rate, fp_rate, tn_rate, fn_rate] =  report_accuracy(confidences, labels);

%Q3.5
feats_test = cat(1,pos_feats_test,neg_feats_test);
labels_test = cat(1,ones(pos_nImages_test,1),-1*ones(neg_nImages_test,1));


fprintf('Classifier performance on test data:\n')
confidences_test = [pos_feats_test; neg_feats_test]*w + b;

[tp_rate, fp_rate, tn_rate, fn_rate] =  report_accuracy(confidences_test, labels_test);

save('my_svm.mat', 'w', 'b');
