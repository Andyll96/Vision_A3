close all
clear
clc

% you might want to have as many negative examples as positive examples
n_have = 0;
n_want = numel(dir('cropped_training_images_faces/*.jpg'));
faceList = dir('cropped_training_images_faces/*.jpg');

imageDir = 'images_notfaces';
imageList = dir(sprintf('%s/*.jpg',imageDir));
nImages = length(imageList);

new_imageDir = 'labeled_cropped_training_images_notfaces';
mkdir(new_imageDir);

dim = 36;

rng(0, 'twister');

x = 1;

num_train = round(n_want*0.8)

%Q3.1
% generate random 36x36 crops from the non-face images

while n_have < n_want
   n_have = n_have + 1
   if x >= nImages
       x = 1
   else
       x = x + 1
   end
   
    neg_name = imageList(x).name;
    neg_path = strcat(imageDir, '/', neg_name);
    negative = im2double(rgb2gray(imread(neg_path)));
    
    [ix, iy] = size(negative);
    
    rx = round(1 + rand(1,1)*((ix-dim)-1));
    ry = round(1 + rand(1,1)*((iy-dim)-1));

    neg_crop = negative(rx: rx+35, ry: ry+35);
    
    %Q3.2
    if n_have <= num_train
        file_n = fullfile(new_imageDir,strcat('Train_',int2str(n_have),'_',neg_name));
    else
        file_n = fullfile(new_imageDir,strcat('Test_',int2str(n_have),'_',neg_name));
    end
    
    imwrite(neg_crop, file_n);

end

%Q3.2
new_imageDir = 'labeled_cropped_training_images_faces';
mkdir(new_imageDir);

y = 1
%TODO: relabel face images
while y < n_want
    y = y + 1
    
    face_name = faceList(y).name;
    face_path = strcat(faceList(y).folder, '/', face_name);
    face = im2double(imread(face_path));
    
    if y <= num_train
        file_n = fullfile(new_imageDir,strcat('Train_',face_name));
    else
        file_n = fullfile(new_imageDir,strcat('Test_',face_name));
    end
    
    imwrite(face, file_n);
end






