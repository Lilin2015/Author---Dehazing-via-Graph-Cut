clear
close all

%% input
imName = '1.bmp';        % <---- your image name
I = imread(imName);
I = im2double(imresize(I,500/max(size(I,1),size(I,2))));I(I>1)=1;I(I<0)=0;
%I = im2double(imresize(I,[480,720]));I(I>1)=1;I(I<0)=0;
%% dehaze
[J, T, A, Cache] = Lee_EnergyMinimization_Dehazing(I);
%% display
figure;imshow(I);
figure;imshow(T);colormap(jet);axis off;
figure;imshow(J);