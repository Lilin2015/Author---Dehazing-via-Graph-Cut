%% initial transmission map estimated by alpha-expansion
% Iw, input image, white balanced
% T, output map, initial transmission map
function [ LS ] = Lee_Get_InitialTrans( I, mask )
    %% prepare
    [m,n,~] = size(I);
    pixel_num = m*n;
    if nargin <= 1
        mask = ceil(0.05*min(m,n));
    end
    %% Label set
    T_lb = im2uint8(1-Get_Dx(I,1));
    Bias = int32(getneighbors(strel('disk',mask)));
    LS = Lee_Cut(T_lb,Bias);
    %% cut
    sc = Lee_Get_Laplacian(Get_Dx(I,1),1);
    sc(logical(tril(sc))) = 0;
    
    dc = double([any(LS(1:75,:));any(LS(76:256,:))]);
    h = BK_Create(pixel_num);
    BK_SetUnary(h,-10000000*dc); 
    BK_SetNeighbors(h,-sc); 
    e = BK_Minimize(h);
    L = BK_GetLabeling(h);
    
    label = double(reshape(L,[m,n]));
    figure;imshow(label-1);
    colormap(jet);axis off;
end

