function [du] = computeDiffusiveTerm_u(u,L)
% computeDiffusiveTerm_u(u,L) integrates the horizontal diffusive term
% du: diffusive term horizontal velocity
% h: cell size
% u: horizontal velocity field
% L: domain size
% Note: this function can only be used with uniform meshes, therefore
% Ax_minus = Ax_plus = Ay = h

    N   = size(u,1)-2;
    h   = L/N;
    du          = zeros(N+2,N+2);

    for j = 2:N+1
       for i = 2:N+1
          de = (u(i+1,j)-u(i,j))/h;
          dw = (u(i,j)-u(i-1,j))/h;
          dn = (u(i,j+1)-u(i,j))/h;
          ds = (u(i,j)-u(i,j-1))/h;
          du(i,j) = (de-dw+dn-ds)*h;
       end
    end

end