clc
clear all
close all

% aquisição da imagem
moire = imread('moire.tif');
[p,q] = size(moire);
imshow(moire);

% criação dos filtros notch
nf1 = zeros(p,q);
for u=1:p
    for v=1:q
        nf1(u,v) = (1/(1+((10/(((u-(p/2)-39)^2)+((v-(q/2)-30)^2)))^4))) * (1/(1+((10/(((u-(p/2)+39)^2)+((v-(q/2)+30)^2)))^4)));
    end
end

nf2 = zeros(p,q);
for u=1:p
    for v=1:q
        nf2(u,v) = (1/(1+((10/(((u-(p/2)+39)^2)+((v-(q/2)-30)^2)))^4))) * (1/(1+((10/(((u-(p/2)-39)^2)+((v-(q/2)+30)^2)))^4)));
    end
end

nf3 = zeros(p,q);
for u=1:p
    for v=1:q
        nf3(u,v) = (1/(1+((5/(((u-(p/2)-78)^2)+((v-(q/2)-30)^2)))^4))) * (1/(1+((5/(((u-(p/2)+78)^2)+((v-(q/2)+30)^2)))^4)));
    end
end

nf4 = zeros(p,q);
for u=1:p
    for v=1:q
        nf4(u,v) = (1/(1+((5/(((u-(p/2)+78)^2)+((v-(q/2)-30)^2)))^4))) * (1/(1+((5/(((u-(p/2)-78)^2)+((v-(q/2)+30)^2)))^4)));
    end
end

notch_filter = nf1 + nf2 + nf3 + nf4;

for u=1:p
    for v=1:q
        notch_filter(u,v) = notch_filter(u,v) - 4;
    end
end

% aplicando o filtro   ----------
moire = double(moire);
notch_filter = double(notch_filter);
fmoire = fftshift(fft2(moire));
filtered = fmoire .* notch_filter;
figure; imshow(uint8(abs(filtered)));
output = ifft2(ifftshift(filtered + fmoire));
figure; imshow(uint8(abs(output)));
