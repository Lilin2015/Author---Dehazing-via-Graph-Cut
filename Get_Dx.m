%% a tool
% I, input image
% step, 1 - D is the minimal map of each channel.
%       2 - D is eroded.
%       3 - D is dark channel.
% r, mask radius
function [ D ] = Get_Dx( I, step, r )
    %% prepare
    [m,n,c] = size(I);
    if nargin <= 2
        r = ceil(0.05*min(m,n));
    end
    if nargin <= 1
        step = 3;
    end
    
    %% step 1. channel min only
    if c == 1
        B = I;
    else
        B = min(I(:,:,1),I(:,:,2));
        B = min(I(:,:,3),B);
    end
    if step <= 1
        D = B;
        return;
    end
    
    %% step 2. erode
    se=strel('disk',r);
    D=imerode(B,se);
    if step <= 2
        return;
    end
    
    %% step 3. refine
    L = get_laplacian(I);
    U = speye(size(L));
    lambda = 0.0001;
    A = L + lambda * U;
    b = lambda * D(:);
    D_refine = A \ b;
    D_refine = reshape(D_refine, m, n);
    D = D_refine;
end

