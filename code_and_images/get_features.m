close all
clear
run('C:\Users\Andys\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')

%TODO: CHANGE TO LABELED DIRECTORIES
%FACES(POSITIVE)
pos_imageDir = 'labeled_cropped_training_images_faces'; %FACES (POSITIVE) DIRECTORY
pos_imageList = dir(sprintf('%s/*.jpg',pos_imageDir)); %FACES (POSITIVE) LIST
pos_nImages = length(pos_imageList); %NUM FACES (POSITIVE)

%NOT FACES (NEGATIVE)
neg_imageDir = 'labeled_cropped_training_images_notfaces'; %NOT FACES (NEGATIVE) DIRECTORY
neg_imageList = dir(sprintf('%s/*.jpg',neg_imageDir)); %NOT FACES (NEGATIVE) LIST
neg_nImages = length(neg_imageList); %NUM NOT FACES (NEGATIVE)

cellSize = 6;
featSize = 31*cellSize^2; %number of gradient directions in each 6x6 bucket

pos_feats = zeros(pos_nImages,featSize); %empty array of size num faces x num descriptors

%loop through the positive images
for i=1:pos_nImages
    im = im2single(imread(sprintf('%s/%s',pos_imageDir,pos_imageList(i).name))); %read the current image
    feat = vl_hog(im,cellSize); %get the HOG of the image,%a descriptor for every pixel
    pos_feats(i,:) = feat(:); %stores each HOG per image 
    fprintf('got feat for pos image %d/%d\n',i,pos_nImages);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

neg_feats = zeros(neg_nImages,featSize);
for i=1:neg_nImages
    im = im2single(imread(sprintf('%s/%s',neg_imageDir,neg_imageList(i).name)));
    feat = vl_hog(im,cellSize);
    neg_feats(i,:) = feat(:);
    fprintf('got feat for neg image %d/%d\n',i,neg_nImages);
%     imhog = vl_hog('render', feat);
%     subplot(1,2,1);
%     imshow(im);
%     subplot(1,2,2);
%     imshow(imhog)
%     pause;
end

save('pos_neg_feats.mat','pos_feats','neg_feats','pos_nImages','neg_nImages')