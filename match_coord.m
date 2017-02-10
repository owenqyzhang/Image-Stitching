function [ x1_m, y1_m, x2_m, y2_m ] = match_coord( x1, y1, x2, y2, match )
%Generating the coordinates of matching features in 2 images.
%   (INPUT) x1, y1: N1×1 vectors representing the coordinates of features
%   in image1.
%   (INPUT) x2, y2: N2×1 vectors representing the coordinates of features
%   in image2.
%   (OUTPUT)match: N1×1 vector of integers where m(i) points to the index 
%   of the descriptor in p2 that matches with the descriptor p1(:,i). If
%   no match is found, m(i) = -1.

x1_m = x1(match > 0);
y1_m = y1(match > 0);

ind = match(match > 0);
x2_m = x2(ind);
y2_m = y2(ind);

end

