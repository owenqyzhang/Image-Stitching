function visual_feat( img, y, x )
    % visualize corner matrix
%     figure;
%     imshow(cimg);
    
    % visualize feature detection
    figure;
    imshow(img,'border','tight','initialmagnification','fit');
    hold on;
    plot(x,y, 'r.', 'MarkerSize', 15);
    hold off;
end

