clc
clear all
close all

mona = imread('morf_test.png');
figure; imshow(mona);%

% filtragem (mediana)
mona = medfilt2(mona,[4 4]);
figure; imshow(mona);%

% bottom-hat/substração do fundo
SE = strel('square',10);
closed_mona = imclose(mona,SE);
figure; imshow(closed_mona);%

bottomhat_mona = closed_mona - mona;
figure; imshow(bottomhat_mona);%

bw_mona = im2bw(bottomhat_mona,0.06);
figure; imshow(bw_mona);

% inversão da imagem (para o fundo ficar branco)
% for u=1:881
%     for v=1:600
%         bottomhat_mona(u,v) = 255 - bottomhat_mona(u,v);
%     end
% end
% figure; imshow(bottomhat_mona);
% 
% % binarização
% bw_mona = im2bw(bottomhat_mona,0.94);
% figure; imshow(bw_mona);%
% 
% % operações morfológicas
% SE = strel('square',2);
% morfo_mona = imopen(bw_mona,SE);
% figure; imshow(morfo_mona);%