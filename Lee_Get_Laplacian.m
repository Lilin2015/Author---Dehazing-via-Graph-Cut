%% get laplacian matrix
% image, input image
% r, neighbor range, laplacian matrix
% L, laplacian matrix
% D, degree matrix
% A, adjacent matrix
function [ L,D,A ] = Lee_Get_Laplacian( image, r )
%GET_LAPLACIAN

[m, n, c] = size(image);
img_size = m*n;
max_num_neigh = (r*2+1)^2;    % num of neighborhood

ind_mat = reshape( 1:img_size, m, n);   % matrix of index, row first
indices = 1 : (m*n);                    % vector of index
num_ind = length(indices);              % max num of index
max_num_vertex = max_num_neigh * num_ind;   % max num of nonzero values in L

row_inds = zeros( max_num_vertex, 1 );  % vector of row index, for sparse matrix construction
col_inds = zeros( max_num_vertex, 1 );  % vector of column index, for sparse matrix construction
vals = zeros( max_num_vertex, 1 );      % corresponding value, for sparse matrix construction

len = 0;        % the first index of currently interested indexs
for k = 1 : length(indices);
    
    ind = indices(k);       % the index of k-th pixel
    
    [i, j] = ind2sub( [m n], ind );     % the row-column of k-th pixel
    
    m_min = max( 1, i - r );
    m_max = min( m, i + r ); 
    n_min = max( 1, j - r );
    n_max = min( n, j + r );
    win_inds = ind_mat( m_min : m_max, n_min : n_max );     
    win_inds = win_inds(:);     % indexs vector of currently interested pixels (under the mask)
    num_neigh = size( win_inds, 1 );    % num of currently interested pixels (under the mask)
    
    win_image = image( m_min : m_max, n_min : n_max, : );
    win_image = reshape( win_image, num_neigh, c );     % color of currently interested pixels, num*3 matrix
    cur_image = image(i,j,:);
    cur_image = reshape( cur_image, 1, c );
    % ****************************************** calc
    mat_diff = win_image - repmat(cur_image,[size(win_image,1),1]);
    mat_diff = abs(mat_diff);
    mat_weight = abs( 1./sum(mat_diff.^2,2));      % ´ÎÊý
    mat_weight(mat_weight>100000)=100000;
    % ****************************************** calc
    sub_len = num_neigh;
    
    row_inds(1+len: len+sub_len) = ind;    % row index of relative pixels
    col_inds(1+len: len+sub_len) = win_inds(:);    % column index of relative pixels    
    vals(1+len: len+sub_len) = mat_weight(:);        % value of relative pixels
    
    len = len + sub_len;  
end

A = sparse(row_inds(1:len),col_inds(1:len),vals(1:len),img_size,img_size);
A(logical(speye(size(A))))=0;
D = spdiags(sum(A,2),0,n*m,n*m);
L = D - A;

end

