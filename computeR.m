function [Ru,Rv] = computeR(u,v,L,nu)
% computeR(u,v,L) calculates the R term as a function of the velocity
% fields
% Written by: Group 13

    N = size(u,1)-2;
    h = L/N;

    % Convective terms computation
    cu = computeConvectiveTerm_u(u,v,L);
    cv = computeConvectiveTerm_v(u,v,L);

    % Diffusive terms computation
    du = computeDiffusiveTerm_u(u,L);
    dv = computeDiffusiveTerm_v(v,L);

    % Rn and Rn-1 terms calculation
    Ru = -cu./(h^2) + nu*du./(h^2);
    Rv = -cv./(h^2) + nu*dv./(h^2);

    % Halo update
    Ru = haloUpdate(Ru);
    Rv = haloUpdate(Rv);
end