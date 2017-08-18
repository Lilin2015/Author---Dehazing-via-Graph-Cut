%% compress T
% T, input trans map, [0,1]
% num, finial range of T
% type, mapping method
% inverse, bool, inverse_mapping
% T, output trans map, [1,num]
function [ T ] = Lee_CompressT( T, num, type, inverse )
    % prepare
    if nargin <= 3
        inverse = 0;
    end
    if nargin <= 2
        type = 'linear';
    end
    gamma = 0.22;
    % linear
    if strcmp(type,'linear') && (~inverse)
        T = round( (num-1)*T+1 );
    end
    % sin
    if strcmp(type,'sin') && (~inverse)
        T = round( (num-1)*sind(T*90)+1 );
    end
    % gamma
    if strcmp(type,'gamma') && (~inverse)
        T = round( (num-1)*T.^gamma+1 );
    end
    % inverse linear
    if strcmp(type,'linear') && (inverse)
        T = (T-1)/(num-1);
    end
    % inverse sin
    if strcmp(type,'sin') && (inverse)
        T = asind((T-1)/(num-1))/90;
    end
    % inverse gamma
    if strcmp(type,'gamma') && (inverse)
        T = ((T-1)/(num-1)).^(1/gamma);
    end
end

