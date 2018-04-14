close all
clear
run('C:\Users\Andys\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')

%TODO: CHANGE TO LABELED DIRECTORIES
%FACES(POSITIVE)
pos_imageDir = 'labeled_cropped_training_images_faces'; %FACES (POSITIVE) DIRECTORY

pos_imageList_train = dir(sprintf('%s/Train_*.jpg',pos_imageDir)); %FACES (POSITIVE) TRAINING LIST
pos_imageList_test = dir(sprintf('%s/Test_*.jpg',pos_imageDir)); %FACES (POSITIVE) TEST LIST

pos_nImages_train = length(pos_imageList_train); %NUM FACES (POSITIVE)TRAINING
pos_nImages_test= length(pos_imageList_test); %NUM FACES (POSITIVE)TRAINING


%NOT FACES (NEGATIVE)
neg_imageDir = 'labeled_cropped_training_images_notfaces'; %NOT FACES (NEGATIVE) DIRECTORY

neg_imageList_train = dir(sprintf('%s/Train_*.jpg',neg_imageDir)); %NOT FACES (NEGATIVE) LIST TRAIN
neg_imageList_test = dir(sprintf('%s/Test_*.jpg',neg_imageDir)); %NOT FACES (NEGATIVE) LIST


neg_nImages_train = length(neg_imageList_train); %NUM NOT FACES (NEGATIVE)
neg_nImages_test = length(neg_imageList_test); %NUM NOT FACES (NEGATIVE)


cellSize = 6;
featSize = 31*cellSize^2; %number of gradient directions in each 6x6 bucket

pos_feats_train = zeros(pos_nImages_train,featSize); %empty array of size num faces x num descriptors
pos_feats_test = zeros(pos_nImages_test,featSize); %empty array of size num faces x num descriptors

%loop through the positive images
for i=1:pos_nImages_train
    im = im2single(imread(sprintf('%s/%s',pos_imageDir,pos_imageList_train(i).name))); %read the current image
    feat = vl_hog(im,cellSize); %get the HOG of the image,%a descriptor for every pixel
    pos_feats_train(i,:) = feat(:); %stores each HOG per image 
    fprintf('got feat for pos image %d/%d\n',i,pos_nImages_train);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

for i=1:pos_nImages_test
    im = im2single(imread(sprintf('%s/%s',pos_imageDir,pos_imageList_test(i).name))); %read the current image
    feat = vl_hog(im,cellSize); %get the HOG of the image,%a descriptor for every pixel
    pos_feats_test(i,:) = feat(:); %stores each HOG per image 
    fprintf('got feat for pos image %d/%d\n',i,pos_nImages_test);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

neg_feats_train = zeros(neg_nImages_train,featSize);
neg_feats_test = zeros(neg_nImages_test,featSize);

for i=1:neg_nImages_train
    im = im2single(imread(sprintf('%s/%s',neg_imageDir,neg_imageList_train(i).name)));
    feat = vl_hog(im,cellSize);
    neg_feats_train(i,:) = feat(:);
    fprintf('got feat for neg image %d/%d\n',i,neg_nImages_train);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

for i=1:neg_nImages_test
    im = im2single(imread(sprintf('%s/%s',neg_imageDir,neg_imageList_test(i).name)));
    feat = vl_hog(im,cellSize);
    neg_feats_test(i,:) = feat(:);
    fprintf('got feat for neg image %d/%d\n',i,neg_nImages_test);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

save('pos_neg_feats.mat','pos_feats_train','pos_feats_test','neg_feats_train','neg_feats_test',...
'pos_nImages_train','pos_nImages_test','neg_nImages_train','neg_nImages_test')