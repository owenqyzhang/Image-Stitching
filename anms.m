function [x, y, rmax] = anms(cimg, max_pts)
%Implement Adaptive Non-Maximal Suppression.
%   (INPUT) cimg: H×W matrix representing the corner strength map.
%   (INPUT) max_pts: number of corners desired.
%   (OUTPUT) x: N×1 vector representing the column coordinates of corners.
%   (OUTPUT) y: N×1 vector representing the row coordinates of corners.
%   (OUTPUT) rmax: suppression radius used to get max_pts corners.

if max_pts >= sum(cimg(:) ~= 0)
    rmax = max(size(cimg, 1), size(cimg, 2))/2;
    [x, y] = find(cimg);
else
    % set a threshold, get rid of small values.
    cimg_sorted = sort(cimg(:), 'descend');
    thresh = cimg_sorted(max_pts * 10);
    cimg = cimg .* (cimg>thresh);
    % the indices and strengths of each corner points.
    [idy, idx] = find(cimg);
    H = cimg(:);
    s = H(sub2ind(size(cimg), idy, idx));
    % the difference in x, y and strength
    X = repmat(idx, 1, length(idx));
    Y = repmat(idy, 1, length(idy));
    S = repmat(s, 1, length(s));
    dx = X - X';
    dy = Y - Y';
    dS = 0.9 * S -  S';
    r = sqrt(dx.^2 + dy.^2);
    % the distances of all the points stronger than the current point
    r_pos = (dS>0) .* r;
    % set the distance of all the points weaker to inf.
    r_pos(r_pos==0)=inf;
    % sort all radius in descend order, pick the max_pts one.
    r_min = min(r_pos);
    rn = min(r_pos);
    rn(rn == inf) = [];
    rn = sort(rn, 'descend');
    rmax = rn(max_pts);
    x = idx(r_min > rmax);
    y = idy(r_min > rmax);
end

end