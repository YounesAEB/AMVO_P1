function [time_step] = computeTimeStep(u,v,L,nu)
% computeTimeStep(u,v,L) calculates an adequate time step to be used
% following the CFL condition
% Written by: Group 13
% Note: 

    N = size(u,1)-2;
    h = L/N;
    f = 0.5;
    stepC = min(min(min((h./abs(u)))),min(min((h./abs(v)))));
    stepD = 0.5*min(h^2./nu);
    time_step = f*min(stepC,stepD);
end