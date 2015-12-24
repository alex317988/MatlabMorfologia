clc
clear all
close all

% aquisição
cell = imread('img_cells.jpg');
cell = rgb2gray(cell);
cell = adapthisteq(cell);
figure; imshow(cell);

% binarização
SE = strel('square',12);
closed_cell = imclose(cell,SE);
bottomhat_cell = closed_cell - cell;

bw_cell = im2bw(bottomhat_cell,graythresh(bottomhat_cell));
figure; imshow(bw_cell);
bw2_cell = imfill(bw_cell,'holes');
bw3_cell = bwareaopen(bw2_cell,20);

for u=1:256
    for v=1:256
        if bw3_cell(u,v) == 1
            bw3_cell(u,v) = 0;
        else
            bw3_cell(u,v) = 1;
        end
    end
end
figure; imshow(bw3_cell);

% watershed
mask_em = imextendedmax(bottomhat_cell,30);
mask_em = imclose(mask_em,ones(5,5));
mask_em = imfill(mask_em,'holes');
mask_em = bwareaopen(mask_em,20);

cell_c = imcomplement(cell);

cell_mod = imimposemin(cell_c, ~bw3_cell | mask_em);
water_cell = watershed(cell_mod);
figure; imshow(water_cell);