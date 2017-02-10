close all;
clc;
clear;

img_mosaic = cell(4, 1);
for imageset_number = 4
    if imageset_number == 1
        %% imageset 1
        I11 = imread('test1/1.jpg');
        I12 = imread('test1/2.jpg');
        %%
        clear img_input;
        img_input{1} = I11;
        img_input{2} = I12;
        
    elseif imageset_number == 2
        %% imageset 2
        I21 = imread('test2/1.jpg');
        I22 = imread('test2/2.jpg');
        I23 = imread('test2/3.jpg');
        I24 = imread('test2/4.jpg');
        %%
        clear img_input;
        img_input{1} = I21;
        img_input{2} = I22;
        img_input{3} = I23;
        img_input{4} = I24;
        
    elseif imageset_number == 3
        %% imageset 3
        I31 = imread('test3/1.jpg');
        I32 = imread('test3/2.jpg');
        I33 = imread('test3/3.jpg');
        I34 = imread('test3/4.jpg');
        I35 = imread('test3/5.jpg');
        I36 = imread('test3/6.jpg');
        I37 = imread('test3/7.jpg');
        I38 = imread('test3/8.jpg');
        I39 = imread('test3/9.jpg');
        %%
        clear img_input;
        img_input{1} = I31;
        img_input{2} = I32;
        img_input{3} = I33;
        img_input{4} = I34;
        img_input{5} = I35;
        img_input{6} = I36;
        img_input{7} = I37;
        img_input{8} = I38;
        img_input{9} = I39;
    elseif imageset_number == 4
        %% imageset 3
        I41 = imread('test4/1.PNG');
        I42 = imread('test4/2.PNG');
        I43 = imread('test4/3.PNG');
        I44 = imread('test4/4.PNG');
        I45 = imread('test4/5.PNG');
        I46 = imread('test4/6.PNG');
        %%
        clear img_input;
        img_input{1} = I41;
        img_input{2} = I42;
        img_input{3} = I43;
        img_input{4} = I44;
        img_input{5} = I45;
        img_input{6} = I46;
    end
    %% Image mosaic
    img_mosaic{imageset_number} = mymosaic(img_input);
    
    %% Show result
    figure;
    imshow(img_mosaic{imageset_number});
end