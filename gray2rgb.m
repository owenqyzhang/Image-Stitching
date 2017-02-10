function [ I_color ] = gray2rgb( I )
    thresh = multithresh(I,4);
    seg_I = imquantize(I,thresh);		% apply the thresholds to obtain segmented image
    I_color = label2rgb(seg_I); 	 % convert to color image
end