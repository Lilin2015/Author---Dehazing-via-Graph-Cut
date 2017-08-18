%% initial transmission map estimated by alpha-expansion
% I, input image
% label_num, range of label
% label, output map, initial transmission map
function [ T ] = Lee_AlphaExpansion( I, label_num )

    %% prepare
    I = im2double(I);
    
    %% form label set of each pixel
    B = round((label_num-1)*Get_Dx(I,1))+1;
    T = Dehaze(B);

end

