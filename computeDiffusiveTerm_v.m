function [dv] = computeDiffusiveTerm_v(v,L)
% computeDiffusiveTerm_v(v,L) integrates the horizontal diffusive term
% dv: diffusive term vertical velocity
% h: cell size
% u: horizontal velocity field
% L: domain size
% Note: this function can only be used with uniform meshes, therefore
% Ax_minus = Ax_plus = Ay_minus = Ay_plus = h


    N   = size(v,1)-2;
    h   = L/N;
    dv  = zeros(N+2,N+2);

    for j = 2:N+1
       for i = 2:N+1
          de = (v(i+1,j)-v(i,j))/h;
          dw = (v(i,j)-v(i-1,j))/h;
          dn = (v(i,j+1)-v(i,j))/h;
          ds = (v(i,j)-v(i,j-1))/h;

          dv(i,j) = (de-dw+dn-ds)*h;
       end
    end
    
end