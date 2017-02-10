function [ img_mosaic ] = mosaic2( I1, I1_gray, I2, I2_gray, H )
%Mosaicing 2 images.
%   (INPUT) img1, img2: H1×W1×3 and H2×W2×3 matrix representing the 2
%   images.

[m1, n1] = size(I1_gray);
[m2, n2] = size(I2_gray);

[N1, M1] = meshgrid(1: n1, 1: m1);
N1 = N1(:);
M1 = M1(:);
[N1_m, M1_m] = apply_homography(H, N1, M1);

N1_min = floor(min(N1_m));
N1_max = ceil(max(N1_m));
M1_min = floor(min(M1_m));
M1_max = ceil(max(M1_m));

n_mosaic = max(N1_max, n2) - min(N1_min, 1) + 1;
m_mosaic = max(M1_max, m2) - min(M1_min, 1) + 1;

I1_m = zeros(m_mosaic, n_mosaic, 3);

[N_mosaic, M_mosaic] = meshgrid(min(N1_min, 1): (min(N1_min, 1)+n_mosaic - 1),...
    min(M1_min, 1): (min(M1_min, 1) + m_mosaic - 1));
N_mosaic = N_mosaic(:);
M_mosaic = M_mosaic(:);
ind_mosaic_homo = [N_mosaic, M_mosaic, ones(length(M_mosaic), 1)];
ind_inv_homo = H\ind_mosaic_homo';
ind_inv = ind_inv_homo' ./ ind_inv_homo(3, :)';
ind_inv = ind_inv(:, 1: 2);

N_inv = reshape(ind_inv(:, 2), m_mosaic, n_mosaic);
M_inv = reshape(ind_inv(:, 1), m_mosaic, n_mosaic);

I1_m(:, :, 1) = interp2(double(I1(:, :, 1)), M_inv, N_inv, 'cubic');
I1_m(:, :, 2) = interp2(double(I1(:, :, 2)), M_inv, N_inv, 'cubic');
I1_m(:, :, 3) = interp2(double(I1(:, :, 3)), M_inv, N_inv, 'cubic');
I1_m(isnan(I1_m)) = 0;

I2_m = zeros(m_mosaic, n_mosaic, 3);
I2_m((2 - min(M1_min, 1)):(m2 - min(M1_min, 1) + 1),...
    (2 - min(N1_min, 1)):(n2 - min(N1_min, 1) + 1), :) = double(I2);

I1_ind = double(sum(I1_m > 0, 3) > 0);
I2_ind = double(sum(I2_m > 0, 3) > 0);
I1_dist = bwdist(~I1_ind);
I2_dist = bwdist(~I2_ind);
I_overlap = I1_dist & I2_dist;
I1_ratio = I1_dist./(I1_dist + I2_dist);
I2_ratio = I2_dist./(I1_dist + I2_dist);
I1_ind(I_overlap) = I1_ratio(I_overlap);
I2_ind(I_overlap) = I2_ratio(I_overlap);

img_mosaic = uint8(I1_m .* I1_ind + I2_m .* I2_ind);

end

