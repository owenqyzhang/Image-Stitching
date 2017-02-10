function [H, inlier_ind] = ransac_est_homography(x1, y1, x2, y2, thresh)
%Use a robust method (RANSAC) to compute a homography. Use 4-point RANSAC.
%   (INPUT) x1, y1, x2, y2: N×1 vectors representing the correspondeces
%   feature coordinates in the first and second image. It means the point
%   (x1i, y1i) in the first image are matched to (x2i, y2i) in the second
%   image.
%   (INPUT) thresh: the threshold on distance used to determine if
%   transformed points agree.
%   (OUTPUT) H: 3×3 matrix representing the homography matrix computed in
%   final step of RANSAC.
%   (OUTPUT) inlier_ind: N×1 vector representing if the correspondence is 
%   inlier or not. 1 means inlier, 0 means outlier.

N = length(x1);
num_inlier_max = 0;
inlier_ind = zeros(N, 1);

for i = 1: 500
    pts = randperm(N, 4);
    xp1 = x1(pts);
    yp1 = y1(pts);
    xp2 = x2(pts);
    yp2 = y2(pts);
    
    H = est_homography(xp2, yp2, xp1, yp1);
    
    [x_est, y_est] = apply_homography(H, x1, y1);
    
    diff = (x2 - x_est).^2 + (y2 - y_est).^2;
    num_inlier = sum(diff < thresh);
    if num_inlier > num_inlier_max
        num_inlier_max = num_inlier;
        inlier_ind = (diff < thresh);
    end
end

x1_inlier = x1(inlier_ind);
y1_inlier = y1(inlier_ind);
x2_inlier = x2(inlier_ind);
y2_inlier = y2(inlier_ind);

H = est_homography(x2_inlier, y2_inlier, x1_inlier, y1_inlier);

end