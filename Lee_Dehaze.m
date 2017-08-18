%% dehaze
% I, input image, balanced
% T, transmission map
% J, haze removal result
function [ J ] = Lee_Dehaze( I, T, A)  
    J = ( I - repmat(reshape(A,[1,1,3]),size(I,1),size(I,2)))./repmat(T,[1,1,size(I,3)])+repmat(reshape(A,[1,1,3]),size(I,1),size(I,2));
end

