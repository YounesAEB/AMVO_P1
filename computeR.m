function [Ru,Rv] = computeR(u,v,L)
% computeR(u,v,L) calculates the R term as a function of the velocity
% fields
% Written by: Group 13
% Note: 
    N = size(u,1)-2;
    h = L/N;
    % Convective terms computation
    cu = computeConvectiveTerm_u(u,v,L);
    cv = computeConvectiveTerm_v(u,v,L);

    % Diffusive terms computation
    du = computeDiffusiveTerm_u(u,L);
    dv = computeDiffusiveTerm_v(v,L);

    % Rn and Rn-1 terms calculation
    Ru = -cu./(h^2) + du./(h^2);
    Rv = -cv./(h^2) + dv./(h^2);
    
end