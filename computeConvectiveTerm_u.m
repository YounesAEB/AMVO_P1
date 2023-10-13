function [cu] = computeConvectiveTerm_u(u,v,L)
% computeConvectuveTerm_u(u,v,L) integrates the horizontal convective term
% cu: convective term horizontal velocity
% h: cell size
% u: horizontal velocity field
% v: vertical velocity field
% L: domain size
% Note: this function can only be used with uniform meshes, therefore 
% Ax_minus = Ax_plus = Ay = h
              
    N           = size(u,1)-2;
    h           = L/N;
    cu          = zeros(N+2,N+2);

    for j=2:N+1 
       for i=2:N+1
          ue = (u(i+1,j)+u(i,j))/2;
          uw = (u(i-1,j)+u(i,j))/2;
          un = (u(i,j+1)+u(i,j))/2;
          us = (u(i,j-1)+u(i,j))/2;
          Fe = ((u(i+1,j)+u(i,j))*h)/2;
          Fw = ((u(i-1,j)+u(i,j))*h)/2;
          Fn = ((v(i,j)+v(i+1,j))*h)/2;
          Fs = ((v(i,j-1)+v(i+1,j-1))*h)/2;

          cu(i,j) = ue*Fe-uw*Fw+un*Fn-us*Fs;
       end
    end
end