function [cimg] = corner_detector(img)
%Detecting corner features in an image.
%   (INPUT) img: H×W matrix representign the grey scale input image.
%   (OUTPUT) cimg: H×W matrix representing the corner metric matrix.

img = imgaussfilt(double(img));

% derivative mask
dx = [-1 1; -1 1];
dy = dx';

% partial derivatives in x and y directions.
Ix = conv2(img, dx, 'same');
Iy = conv2(img, dy, 'same');

% convolution of image derivatives and window function
Ix2 = imgaussfilt(Ix.^2);
Iy2 = imgaussfilt(Iy.^2);
Ixy = imgaussfilt(Ix.*Iy);

% Harris corner strength
cimg = (Ix2.*Iy2 - Ixy.^2)./(Ix2 + Iy2 + eps);

end
