function [descs] = feat_desc(img, x, y)
%Extracting Feature Descriptor for each feature point.
%   (INPUT) img: H×W matrix representing the gray scale input image.
%   (INPUT) x: n×1 vector representing the column coordinates of corners.
%   (INPUT) y: n×1 vector representing the row coordinates of corners.
%   (OUTPUT) descs: 64×n matrix of double values with column i being the 
%   64 dimensional descriptor computed at location (xi, yi) in img.

% blur the image with gaussian filter
im_filtered = imgaussfilt(double(img), 2, 'FilterSize', 5);
im_filt_pad = padarray(im_filtered, [20 20], 'both');
% the indices of each sampling points
x = x + 20;
y = y + 20;
xs = [x-15, x-10, x-5, x, x+5, x+10, x+15, x+20];
ys = [y-15, y-10, y-5, y, y+5, y+10, y+15, y+20];
% reshape all the indices
x_rep = repmat(reshape(xs', 1, 8, length(x)), 8, 1, 1);
y_rep = permute(repmat(reshape(ys', 1, 8, length(y)), 8, 1, 1), [2 1 3]);
xs_vec = reshape(x_rep, 64*length(x), 1);
ys_vec = reshape(y_rep, 64*length(y), 1);
ind = sub2ind(size(im_filt_pad), ys_vec, xs_vec);
% feature descriptor
im_vec = im_filt_pad(:);
descs = reshape(im_vec(ind), 64, length(x));
mu = mean(descs);
sigma = std(descs);
descs = (descs - mu) ./ sigma;

end