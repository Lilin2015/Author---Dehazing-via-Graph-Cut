%% energy minimization dehazing
% I, input image
% J, dehazing result
% T, transmission map
% A, atmospheric color
% Cache, Intermediate data 
function [ J, T, A, Cache] = Lee_EnergyMinimization_Dehazing( I )

    Cache = cell(3,1);
    
    %% atmospheric color estimate
    fprintf('est. atmospheric color...\n');
    A = Lee_Get_A(I);
    t1=clock;
    Iw = Lee_Get_WhiteI(I);

    %% solve initial T, alpha-exphansion
    fprintf('est. initial transmission map...\n');
    tic;
    Labels = GraphCut(min(1,max(0,Get_Dx(Iw,1))));
    fprintf('Graph cut takes %0.2f second\n',toc);
    T_initial = 1-(Labels-1)/31; 
    
    %% regularization
    fprintf('regularization...\n');
    %T_reg=Lee_Regularization(Iw,T_initial,10000,5);
    tic;
    T_reg=wls_optimization(T_initial,I,0.01);
    fprintf('regularization takes %0.2f second\n',toc);
    %% brighter
    haze_factor = 1.1;
    gamma = 1;
    T = (T_reg + (haze_factor-1) )/haze_factor;
    fprintf('dehazing...\n');

    J1 = Lee_Dehaze(Iw,T,[1,1,1]).*repmat(reshape(A,[1,1,3]),size(I,1),size(I,2));
    J = J1;
    J(J>0)=J(J>0).^gamma;
    
    t2=clock;
    runtime = etime(t2,t1);
    fprintf('overall run-time is %0.2f second\n',runtime);
    %% Intermediate data save
    Cache{1} = T_initial;

end

