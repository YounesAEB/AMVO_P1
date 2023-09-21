function [u,v] = setVelocityField (xsu,ysu,xsv,ysv,N)
% set_velocity_field(N,L) creates a velocity field from an analytic
% velocity distribution
% u: horizontal velocity field
% v: vertical velocity field
% N: mesh size
% L: domain size
% h: cell size
% Note: assign the east and north values of the cells, starting at (2,2)

    u = zeros(N+2,N+2);
    v = zeros(N+2,N+2);

    for i=2:N+1
       for j=2:N+1
           u(i,j) = cos(2*pi*xsu(i,j))*sin(2*pi*ysu(i,j));
           v(i,j) = -sin(2*pi*xsv(i,j))*cos(2*pi*ysv(i,j));
       end
    end

    u = haloUpdate(u);
    v = haloUpdate(v);
end