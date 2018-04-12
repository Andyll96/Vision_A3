% you might want to have as many negative examples as positive examples
n_have = 0;
n_want = numel(dir('cropped_training_images_faces/*.jpg'));

imageDir = 'images_notfaces';
imageList = dir(sprintf('%s/*.jpg',imageDir));
nImages = length(imageList);

new_imageDir = 'cropped_training_images_notfaces';
mkdir(new_imageDir);

dim = 36;

rng(0, 'twister');

x = 1;

% generate random 36x36 crops from the non-face images
while n_have < n_want
   n_have = n_have + 1
   if x >= nImages
       x = 1;
   else
       x = x + 1
   end
   
    neg_name = imageList(x).name;
    neg_path = strcat(imageDir, '/', neg_name);
    negative = im2double(rgb2gray(imread(neg_path)));
    
    [ix, iy] = size(negative);
    
    rx = round(rand(1,1)*((ix - dim)));
    ry = round(rand(1,1)*((iy - dim)));

    neg_crop = imcrop(negative, [rx, ry, dim - 1, dim - 1]);
    [nx,ny,np] = size(neg_crop);
    
    file_n = fullfile(new_imageDir,strcat(int2str(x),'_',neg_name));
    
        %TODO: some of the cropped images have a dimension of 0
    if nx ~= 0 || ny ~= 0 
        imwrite(neg_crop, file_n);
    end  
end








