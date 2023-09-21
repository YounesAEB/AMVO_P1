function [cv] = convective_v(u,v,L)
% convective_v(u,v,L) integrates the horizontal convective term
% cv: convective term vertical velocity
% h: cell size
% u: horizontal velocity field
% v: vertical velocity field
% L: domain size
% Note: this function can only be used with uniform meshes, therefore
% Ax_minus = Ax_plus = Ay = h
              

    N   = size(u,1)-2;
    h   = L/N;
    cv  = zeros(N+2,N+2);

    for j=2:N+1 
       for i=2:N+1
          ve = (v(i+1,j)+v(i,j))/2;
          vw = (v(i-1,j)+v(i,j))/2;
          vn = (v(i,j+1)+v(i,j))/2;
          vs = (v(i,j-1)+v(i,j))/2;
          Fe = ((u(i,j)+u(i,j+1))*h)/2;
          Fw = ((u(i-1,j)+u(i-1,j+1))*h)/2;
          Fn = ((v(i,j+1)+v(i,j))*h)/2;
          Fs = ((v(i,j)+v(i,j-1))*h)/2;
          
          cv(i,j) = ve*Fe-vw*Fw+vn*Fn-vs*Fs;
       end
    end
end