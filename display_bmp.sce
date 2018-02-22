/* 
 RhinoPower Ltd 
 v0.1 
 22nd February 2018 

Display bitmap using the Image processing Toolbox 

*/

filename = uigetfile('*.bmp','all image files');
Image = imread(filename);
imshow(Image);
