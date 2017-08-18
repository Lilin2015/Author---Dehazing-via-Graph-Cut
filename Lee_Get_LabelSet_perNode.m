%% form label set on each pixel
% B, lower bound map
% mask_r, mask radius
% Label_set, label set structure
function Label_set = Lee_Get_LabelSet_perNode( B, mask_r )
    
    [m,n,~] = size(B);
    if nargin <= 1
        mask_r = ceil(0.05*min(m,n));
    end
    
    pixel_num = m*n;
    Label_set = cell(pixel_num,1);

    bias = getneighbors(strel('disk',mask_r));
    bias_m = bias(:,1); bias_n = bias(:,2);
    taping_width = max(bias_m(:));
    m_taping = m+taping_width*2;
    n_taping = n+taping_width*2;
    B_taping = -ones([m_taping,n_taping]);
    B_taping(taping_width+1:taping_width+m,taping_width+1:taping_width+n,1) = B;
    B_layers = repmat(B_taping,[1,1,size(bias_m,1)]);

    idx = repmat({':'}, 2, 1);
    for i = 1:size(bias_m,1)
        if  bias_m(i) < 0
            idx{1} = [ -bias_m(i)+1:m_taping 1:-bias_m(i) ];  % ÉÏÒÆ
        elseif bias_m(i) > 0
            idx{1} = [ m_taping-bias_m(i)+1:m_taping 1:m_taping-bias_m(i) ];
        else
            idx{1} = ':';
        end 
        if  bias_n(i) < 0
            idx{2} = [ -bias_n(i)+1:n_taping 1:-bias_n(i) ];  % ×óÒÆ
        elseif bias_n(i) > 0
            idx{2} = [ n_taping-bias_n(i)+1:n_taping 1:n_taping-bias_n(i) ];
        else
            idx{2} = ':';
        end       
        B_layers(:,:,i) = B_taping(idx{:});
    end
    
    B_layers_cut = B_layers(taping_width+1:taping_width+m,taping_width+1:taping_width+n,:);
    B_layers_cut = min(B_layers_cut,repmat(B,[1,1,size(B_layers_cut,3)]));
    for i = 1: pixel_num
        [im,in]=ind2sub([m,n],i);
        temp_Label = B_layers_cut(im,in,:);  
        temp_Label(temp_Label==-1)=[];
        temp_Label = unique(temp_Label(:));
        Label_set{i} = temp_Label;        
    end
end

