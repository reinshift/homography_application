clear;clc;close all;
%% initing images
image1 = imread('left.jpg');
% image1 = imrotate(image1,-90);
image2 = imread('template.jpg');
image2 = imrotate(image2,180);

ptsImage1 = zeros(4,2);
ptsImage2 = zeros(4,2);

figure;
imshow(image1);
hold on;
for i = 1:4
    [x,y] = ginput(1);
    ptsImage1(i,1) = x;
    ptsImage1(i,2) = y;
    plot(x,y,'ro');
    drawnow;
end
hold off;
disp('press any key to continue.');
waitforbuttonpress;
close;

figure;
imshow(image2);
hold on;
for i = 1:4
    [x,y] = ginput(1);
    ptsImage2(i,1) = x;
    ptsImage2(i,2) = y;
    plot(x,y,'ro');
    drawnow;
end
hold off;
disp('press any key to continue.');
waitforbuttonpress;
close;

%% compute & apply homography matrix
H = computeHomography(ptsImage1, ptsImage2);

transformedImage = applyHomography(image1,H);

%% show result
figure;
subplot(1,2,1);
imshow(image1);
title('Original Image');

subplot(1,2,2);
imshow(transformedImage);
title('Transformed Image');
% save('trans_left.mat','transformedImage');
