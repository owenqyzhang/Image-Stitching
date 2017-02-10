function visual_match( img1, img2, x1, y1, x2, y2, inlier)
    x1_inlier = x1(inlier ~= 0);
    y1_inlier = y1(inlier ~= 0);
    x2_inlier = x2(inlier ~= 0) + size(img1, 2);
    y2_inlier = y2(inlier ~= 0); 
    x1_outlier = x1(inlier == 0);
    y1_outlier = y1(inlier == 0);
    x2_outlier = x2(inlier == 0) + size(img1, 2);
    y2_outlier = y2(inlier == 0); 
%     
%     % visualize image 1 inliers and outliers
%     figure;
%     imshow(img1);
%     hold on;
%     scatter(x1_inlier,y1_inlier, 'b.');    
%     scatter(x1_outlier,y1_outlier, 'rx');    
%     hold off;
% 
%     % visualize image 2 inliers and outliers
%     figure;
%     imshow(img2);
%     hold on;
%     scatter(x2_inlier,y2_inlier, 'b.');    
%     scatter(x2_outlier,y2_outlier, 'rx');    
%     hold off;

figure;
imshowpair(img1, img2, 'montage');
hold on
plot(x1, y1, 'r.', 'MarkerSize', 20);
plot(x2+size(img1, 2), y2, 'r.', 'MarkerSize', 20);
for i = 1: length(x1)
    line([x1(i), x2(i) + size(img1, 2)], [y1(i), y2(i)], 'Color', 'y');
end

figure;
imshowpair(img1, img2, 'montage');
hold on
plot(x1_inlier, y1_inlier, 'b.', 'MarkerSize', 20);
plot(x2_inlier, y2_inlier, 'b.', 'MarkerSize', 20);
plot(x1_outlier, y1_outlier, 'rx', 'MarkerSize', 10);
plot(x2_outlier, y2_outlier, 'rx', 'MarkerSize', 10);
for i = 1: length(x1_inlier)
    line([x1_inlier(i), x2_inlier(i)], [y1_inlier(i), y2_inlier(i)], 'Color', 'y');
end
end