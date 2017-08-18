%% regularization
% I, input image
% T, input transmission map
% lambda, weight of data term
% r, neighbor range, laplacian matrix
function [ T ] = Lee_Regularization( I, T_initial, lambda, r )

    L = Lee_Get_Laplacian(I,r);
    U = speye(size(L));
    A = L + lambda * U;
    b = lambda * T_initial(:);
    T = A \ b;
    T = reshape(T, size(T_initial));
    
%     T = T - min(T(:));
%     T = T./max(T(:));
%     T = (max(T_initial(:))-min(T_initial(:)))*T+min(T(:));
end

