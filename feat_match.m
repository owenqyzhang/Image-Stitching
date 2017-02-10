function [match] = feat_match(descs1, descs2)
%Matching these feature descriptors between two images.
%   (INPUT)descs1: 64×N1 matrix representing the corner descriptors of 
%   first image.
%   (INPUT)descs2: 64×N2 matrix representing the corner descriptors of 
%   first image.
%   (OUTPUT)match: N1×1 vector of integers where m(i) points to the index 
%   of the descriptor in p2 that matches with the descriptor p1(:,i).
%   If no match is found, m(i) = -1.

% reshape the descriptors
feat1_rep = repmat(descs1, 1, 1, size(descs2, 2));
feat2 = reshape(descs2, 64, 1, size(descs2, 2));
feat2_rep = repmat(feat2, 1, size(descs1, 2), 1);
% calculate ssd
ssd = reshape(sum((feat1_rep - feat2_rep).^2), size(descs1, 2), size(descs2, 2))';
ssd_sorted = sort(ssd);
% find the ratio between 1-nn and 2-nn
ratio = ssd_sorted(1, :) ./ ssd_sorted(2, :);
% get the indices of 1-nn and only take those with 1-nn/2-nn < 0.7
[c, ~] = find(ssd == ssd_sorted(1, :));
match = (ratio' < 0.7) .* c;
match(match == 0) = -1;

end