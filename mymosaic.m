function [img_mosaic] = mymosaic(img_input)
%Produce a mosaic by overlaying the pariwise aligned images to create the
%final mosaic image.
%   (INPUT) img_input: M elements cell array, each element is an input
%   image.
%   (OUTPUT img_mosaic: H×W×3 matrix representing the final mosaic image.

I2 = img_input{1};

I2_gray = rgb2gray(I2);
cimg2 = corner_detector(I2_gray);
[x2, y2, ~] = anms(cimg2, 500);
descs2 = feat_desc(I2_gray, x2, y2);

num_match = 0;

for i = 2: length(img_input)
    I_cand = img_input{i};
    I_cand_gray = rgb2gray(I_cand);
    cimg_cand = corner_detector(I_cand_gray);
    [x_cand, y_cand, ~] = anms(cimg_cand, 500);
    descs_cand = feat_desc(I_cand_gray, x_cand, y_cand);
    
    match_cand = feat_match(descs2, descs_cand);
    [x2_m, y2_m, x_cand_m, y_cand_m] = match_coord(x2, y2,...
        x_cand, y_cand, match_cand);
    [H_cand, inlier_cand] = ransac_est_homography(x2_m, y2_m,...
        x_cand_m, y_cand_m, 10);
    if sum(inlier_cand) > num_match
        num_match = sum(inlier_cand);
        I1 = I_cand;
        I1_gray = I_cand_gray;
        H = H_cand;
        img_chosen = i;
    end
end

img_mosaic = mosaic2_blend(I2, I2_gray, I1, I1_gray, H);
img_mosaic(:, all(~sum(img_mosaic, 3)), :) = [];
img_mosaic(all(~sum(img_mosaic, 3), 2), :, :) = [];

img_input{1} = [];
img_input{img_chosen} = [];

for i = 3: length(img_input)
    I2 = img_mosaic;

    I2_gray = rgb2gray(I2);
    cimg2 = corner_detector(I2_gray);
    [x2, y2, ~] = anms(cimg2, 500);
    descs2 = feat_desc(I2_gray, x2, y2);
    
    num_match = 0;
    
    for j = 1: length(img_input)
        if isempty(img_input{j})
            continue;
        end
        I_cand = img_input{j};
        I_cand_gray = rgb2gray(I_cand);
        cimg_cand = corner_detector(I_cand_gray);
        [x_cand, y_cand, ~] = anms(cimg_cand, 500);
        descs_cand = feat_desc(I_cand_gray, x_cand, y_cand);
        
        match_cand = feat_match(descs2, descs_cand);
        [x2_m, y2_m, x_cand_m, y_cand_m] = match_coord(x2, y2,...
            x_cand, y_cand, match_cand);
        [H_cand, inlier_cand] = ransac_est_homography(x2_m, y2_m,...
            x_cand_m, y_cand_m, 100);
        if sum(inlier_cand) > num_match
            num_match = sum(inlier_cand);
            I1 = I_cand;
            I1_gray = I_cand_gray;
            H = H_cand;
            img_chosen = j;
        end
    end
    
    img_mosaic = mosaic2_blend(I2, I2_gray, I1, I1_gray, H);
    img_mosaic(:, all(~sum(img_mosaic, 3)), :) = [];
    img_mosaic(all(~sum(img_mosaic, 3), 2), :, :) = [];

    img_input{img_chosen} = [];
end

end