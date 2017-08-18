%% estimate A based on Retinex Theory
% I, input image
% A, atmospheric color
function [ A ] = Lee_Get_A( I )
    A = get_atmosphere(im2double(I), get_dark_channel(I, 25));
end

