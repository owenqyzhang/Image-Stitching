%%
clear
clc

%%
I1 = imread('1.jpg');
I2 = imread('2.jpg');

%%
I1_gray = rgb2gray(I1);
I2_gray = rgb2gray(I2);

%%
cimg1 = corner_detector(I1_gray);
cimg2 = corner_detector(I2_gray);

%%
[x1, y1, rmax1] = anms(cimg1, 500);
[x2, y2, rmax2] = anms(cimg2, 500);

%%
descs1 = feat_desc(I1_gray, x1, y1);
descs2 = feat_desc(I2_gray, x2, y2);

%%
match = feat_match(descs1, descs2);
[x1_m, y1_m, x2_m, y2_m] = match_coord(x1, y1, x2, y2, match);

%%
[H, inlier] = ransac_est_homography(x1_m, y1_m, x2_m, y2_m, 100);

x1_inlier = x1_m(inlier ~= 0);
y1_inlier = y1_m(inlier ~= 0);
x2_inlier = x2_m(inlier ~= 0);
y2_inlier = y2_m(inlier ~= 0); 
x1_outlier = x1_m(inlier == 0);
y1_outlier = y1_m(inlier == 0);
x2_outlier = x2_m(inlier == 0);
y2_outlier = y2_m(inlier == 0); 

%%
figure;
subplot(2, 2, 1);
imshow(I1);
hold on;
plot(x1, y1, 'r.');
subplot(2, 2, 2);
imshow(I2);
hold on;
plot(x2, y2, 'r.');
subplot(2, 2, 3);
hold on;
imshow(I1);
scatter(x1_inlier,y1_inlier, 'b.');
scatter(x1_outlier,y1_outlier, 'rx');
subplot(2, 2, 4);
imshow(I2);
hold on;
scatter(x2_inlier,y2_inlier, 'b.');
scatter(x2_outlier,y2_outlier, 'rx');
