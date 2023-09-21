%--------------------------------------------------------------------------
%  /  NAVIER-STOKES ASSIGNMENT - Part A  
%  /  Matlab code to assess the numerical solution of NS equations                                            
%  /  ESEIAAT_UPC                                           
%  /  MUEA - MQ1 - Younes Akhazzan - Joel Rajo - Pol Ruiz - G13                         
%--------------------------------------------------------------------------
clc; clear; close all;

% Input parameters
Naux = [8,16,32,64,128]; % mesh size
L = 1; % domain size
error = zeros(size(Naux,2),4);

for i=1:size(Naux,2)
    % Preliminary steps 
    N                   = Naux(i);
    [xsu,ysu,xsv,ysv]   = setCoordinates(N,L);
    [u,v]               = setVelocityField(xsu,ysu,xsv,ysv,N);
    
    % Convective terms computation
    cu = computeConvectiveTerm_u(u,v,L);
    cv = computeConvectiveTerm_v(u,v,L);
    
    % Diffusive terms computation
    du = computeDiffusiveTerm_u(u,L);
    dv = computeDiffusiveTerm_v(v,L);
    
    % Analytic values computation
    [cu_an,cv_an,du_an,dv_an] = computeAnalyticValues(xsu,xsv,ysu,ysv);
    
    % Error computation
    [ecu,ecv,edu,edv]   = computeError(cu,cv,du,dv,cu_an,cv_an,du_an,dv_an,L);
    error(i,:)          = [ecu,ecv,edu,edv];
end

% Results plot
plotError(error,L,Naux);


