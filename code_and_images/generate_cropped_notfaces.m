% you might want to have as many negative examples as positive examples
n_have = 0;
n_want = numel(dir('cropped_training_images_faces/*.jpg'));

imageDir = 'images_notfaces';
imageList = dir(sprintf('%s/*.jpg',imageDir));
nImages = length(imageList);

new_imageDir = 'cropped_training_images_notfaces';
mkdir(new_imageDir);

dim = 36;

%Question 3.1

%while n_have < n_want
    
    % generate random 36x36 crops from the non-face images
    
%end

for x = 1:nImages
    
    im_name = imageList(x).name;
    im_read = strcat(imageDir,'/',im_name);
    im = imread(im_read);
    im = rgb2gray(im);
    
    [ix,iy] = size(im);
    
    rx = round(rand(1,1)*((ix - dim)));
    ry = round(rand(1,1)*((iy - dim)));
  
    im_n = imcrop(im, [rx, ry, dim - 1, dim - 1]);
    [nx,ny,np] = size(im_n);
 
    file_n = fullfile(new_imageDir,im_name);
    
    %TODO: some of the cropped images have a dimension of 0
    if nx ~= 0 || ny ~= 0 
        imwrite(im_n, file_n);
    end   
end 