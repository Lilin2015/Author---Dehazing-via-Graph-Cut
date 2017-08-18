%% white balance based on Retinex theory
% I, input image
% I, output image, balanced
function [ Iw ] = Lee_Get_WhiteI( I )

[~,~,c] = size(I);
A = Lee_Get_A(I);
if c==3
    Iw(:,:,1) = I(:,:,1) ./ A(1);
    Iw(:,:,2) = I(:,:,2) ./ A(2);
    Iw(:,:,3) = I(:,:,3) ./ A(3);
else
    Iw = I./A;
end

end

