close all
clear
clc
run('C:\Users\Andys\Downloads\vlfeat-0.9.21-bin\vlfeat-0.9.21\toolbox\vl_setup')

pic = im2single(imread('Traincaltech_web_crop_00001.jpg'));

cellSize = 8 ;
hog = vl_hog(pic, cellSize, 'verbose') ;

imhog = vl_hog('render', hog, 'verbose') ;
clf ; imagesc(imhog) ; colormap gray ;